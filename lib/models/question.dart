// Model data untuk satu soal pilihan ganda.
class Question {
  final String question; // teks soal
  final List<String> options; // tepat 4 pilihan (A, B, C, D)
  final int correctIndex; // indeks jawaban benar: 0 = A, 1 = B, dst.
  final String explanation; // penjelasan singkat untuk halaman pembahasan

  const Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
