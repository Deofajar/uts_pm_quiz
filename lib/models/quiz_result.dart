import 'question.dart';
import 'subject.dart';

// Hasil satu kali mengerjakan kuis. Dibuat saat jawaban dikirim,
// lalu dipakai oleh halaman hasil dan halaman pembahasan.
class QuizResult {
  final Subject subject;
  final List<Question> questions;
  final List<int?> answers; // jawaban user per soal (null = tidak dijawab)
  final int correctCount; // jumlah jawaban benar
  final int score; // skor 0–100

  const QuizResult({
    required this.subject,
    required this.questions,
    required this.answers,
    required this.correctCount,
    required this.score,
  });

  // Jumlah seluruh soal.
  int get totalQuestions => questions.length;

  // Jumlah soal yang tidak dijawab (jawabannya null).
  int get unansweredCount {
    int count = 0;
    for (final answer in answers) {
      if (answer == null) count++;
    }
    return count;
  }

  // Jumlah soal yang dijawab tapi salah.
  int get wrongCount => totalQuestions - correctCount - unansweredCount;

  // True kalau soal ke-[index] dijawab.
  bool isAnswered(int index) => answers[index] != null;

  // True kalau jawaban soal ke-[index] sama dengan kunci jawaban.
  bool isCorrect(int index) => answers[index] == questions[index].correctIndex;
}
