import 'package:flutter/material.dart';

import '../data/question_data.dart';
import '../models/question.dart';
import '../models/quiz_result.dart';
import '../models/subject.dart';

// QuizProvider = tempat menyimpan SEMUA data kuis (state management).
//
// Cara kerjanya:
// 1. Provider dipasang di main.dart, DI ATAS MaterialApp. Jadi objek ini
//    hanya dibuat sekali dan tetap hidup walaupun halaman berganti atau
//    layar dirotasi. Itu sebabnya progres jawaban tidak hilang.
// 2. Halaman membaca data dengan context.watch<QuizProvider>().
// 3. Setiap kali data diubah, kita panggil notifyListeners(), sehingga
//    semua halaman yang "watch" otomatis dibangun ulang dengan data baru.
class QuizProvider extends ChangeNotifier {
  // ===================== Nama pengguna (Halaman 1) =====================
  String _userName = '';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name.trim(); // buang spasi di awal & akhir
    notifyListeners();
  }

  // ================= Mata pelajaran yang dipilih (Halaman 2) =================
  Subject? selectedSubject; // null = belum memilih

  // ========================= Skor terakhir =========================
  // Kunci = id mapel, nilai = skor 0–100. Diisi saat kuis dikirim.
  Map<String, int> lastScores = {};

  // Mengembalikan skor terakhir, atau null kalau mapel belum pernah dicoba.
  int? lastScoreOf(String subjectId) {
    return lastScores[subjectId];
  }

  // ================== Progres kuis PER MAPEL (Halaman 3) ==================
  // Progres disimpan per mapel (kunci = id mapel), supaya kalau user keluar
  // ke halaman mapel lalu masuk lagi, jawabannya masih ada.

  // Jawaban per mapel. Isi list: indeks opsi yang dipilih (0–3),
  // atau null kalau soal itu belum dijawab.
  final Map<String, List<int?>> _answers = {};

  // Nomor soal (indeks) terakhir yang dibuka per mapel.
  final Map<String, int> _currentIndex = {};

  // Hasil kuis terakhir yang dikirim (dipakai halaman hasil).
  QuizResult? lastResult;

  // ----------------------------- Getter -----------------------------

  // Daftar soal untuk mapel yang sedang dipilih.
  List<Question> get questions {
    if (selectedSubject == null) return [];
    return questionBank[selectedSubject!.id] ?? [];
  }

  // Indeks soal yang sedang dibuka (0 = soal pertama).
  int get currentIndex {
    if (selectedSubject == null) return 0;
    return _currentIndex[selectedSubject!.id] ?? 0;
  }

  Question get currentQuestion => questions[currentIndex];

  // Semua jawaban untuk mapel yang sedang dipilih.
  List<int?> get answers {
    if (selectedSubject == null) return [];
    return _answers[selectedSubject!.id] ?? [];
  }

  // Jawaban untuk soal yang sedang dibuka (null = belum dijawab).
  int? get selectedAnswer {
    if (answers.isEmpty) return null;
    return answers[currentIndex];
  }

  // Jumlah soal yang sudah dijawab pada mapel yang sedang dipilih.
  int get answeredCount {
    if (selectedSubject == null) return 0;
    return answeredCountOf(selectedSubject!.id);
  }

  bool get isFirstQuestion => currentIndex == 0;

  bool get isLastQuestion => currentIndex == questions.length - 1;

  // Jumlah soal yang sudah dijawab pada mapel tertentu.
  int answeredCountOf(String subjectId) {
    final list = _answers[subjectId];
    if (list == null) return 0;

    int count = 0;
    for (final answer in list) {
      if (answer != null) count++;
    }
    return count;
  }

  // True kalau mapel ini sudah dijawab minimal 1 soal dan belum dikirim.
  // (Progres dihapus saat dikirim, jadi kalau masih ada jawaban
  // berarti kuisnya belum dikirim.)
  bool isInProgress(String subjectId) {
    return answeredCountOf(subjectId) > 0;
  }

  // ----------------------------- Method -----------------------------

  // Dipanggil saat user memilih mapel di Halaman 2.
  void selectSubject(Subject subject) {
    selectedSubject = subject;

    // Kalau mapel ini belum punya progres, siapkan jawaban kosong.
    // Kalau sudah punya, JANGAN direset supaya user bisa melanjutkan.
    if (!_answers.containsKey(subject.id)) {
      final total = questionBank[subject.id]?.length ?? 0;
      _answers[subject.id] = List<int?>.filled(total, null);
      _currentIndex[subject.id] = 0;
    }
    notifyListeners();
  }

  // Simpan jawaban untuk soal yang sedang dibuka.
  // Jawaban boleh diganti berkali-kali selama kuis belum dikirim.
  void selectAnswer(int optionIndex) {
    if (selectedSubject == null) return;
    final list = _answers[selectedSubject!.id];
    if (list == null) return; // kuis sudah dikirim / belum dimulai
    list[currentIndex] = optionIndex;
    notifyListeners();
  }

  // Pindah ke soal berikutnya (kalau belum di soal terakhir).
  void nextQuestion() {
    if (isLastQuestion) return;
    goToQuestion(currentIndex + 1);
  }

  // Pindah ke soal sebelumnya (kalau belum di soal pertama).
  void previousQuestion() {
    if (isFirstQuestion) return;
    goToQuestion(currentIndex - 1);
  }

  // Lompat langsung ke soal tertentu (dari bar nomor soal).
  void goToQuestion(int index) {
    if (selectedSubject == null) return;
    if (index < 0 || index >= questions.length) return; // cek batas
    _currentIndex[selectedSubject!.id] = index;
    notifyListeners();
  }

  // Kirim jawaban: hitung skor, simpan hasil, lalu hapus progres mapel ini.
  void submitQuiz() {
    final subject = selectedSubject;
    if (subject == null) return;

    final questionList = questions;
    final answerList = answers;

    // Hitung jumlah jawaban yang benar
    int correctCount = 0;
    for (int i = 0; i < questionList.length; i++) {
      if (answerList[i] == questionList[i].correctIndex) {
        correctCount++;
      }
    }

    // Skor = benar / jumlah soal × 100, dibulatkan
    final score = (correctCount / questionList.length * 100).round();

    lastResult = QuizResult(
      subject: subject,
      questions: questionList,
      answers: List<int?>.from(answerList), // salinan, bukan list aslinya
      correctCount: correctCount,
      score: score,
    );
    lastScores[subject.id] = score;

    // Hapus progres supaya kalau kuis diulang, mulai dari nol.
    _answers.remove(subject.id);
    _currentIndex.remove(subject.id);

    notifyListeners();
  }
}
