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
}
