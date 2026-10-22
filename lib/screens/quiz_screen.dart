import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_number_bar.dart';
import '../widgets/secondary_button.dart';
import '../widgets/square_icon_button.dart';
import '../widgets/theme_toggle_button.dart';

// HALAMAN 3: halaman soal.
// SATU halaman ini menampilkan SEMUA soal; soal yang tampil ditentukan
// oleh currentIndex di QuizProvider (bukan satu file per soal).
//
// Cukup StatelessWidget karena semua data (soal, jawaban, nomor soal)
// disimpan di QuizProvider. Akibatnya progres tidak hilang saat layar
// dirotasi atau saat keluar lalu masuk lagi ke halaman ini.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  static const List<String> letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();

    // context.watch: halaman dibangun ulang setiap data kuis berubah
    final quizProvider = context.watch<QuizProvider>();

    // Halaman dibuka tanpa memilih mapel (mis. lewat URL di web)
    if (quizProvider.selectedSubject == null ||
        quizProvider.questions.isEmpty) {
      return _buildNoSubject(context, scale);
    }

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Layar lebar: kartu soal dan opsi dibuat dua kolom
            final isWide = constraints.maxWidth >= 720;
            // Layar pendek (mis. HP lanskap): seluruh halaman di-scroll
            final isShort = constraints.maxHeight < 500;

            final header = _buildHeader(context, quizProvider, scale);
            final progress = _buildProgress(context, quizProvider, scale);
            final questionCard =
                _buildQuestionCard(context, quizProvider, scale);
            final options = _buildOptions(quizProvider, scale);
            final numberBar = QuestionNumberBar(
              total: quizProvider.questions.length,
              currentIndex: quizProvider.currentIndex,
              answers: quizProvider.answers,
              onTap: quizProvider.goToQuestion,
            );
            final buttons = _buildButtons(context, quizProvider, scale);

            Widget content;
            if (isShort) {
              // Semua isi ikut di-scroll supaya tidak overflow
              content = SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    header,
                    SizedBox(height: 16 * scale),
                    progress,
                    SizedBox(height: 16 * scale),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: questionCard),
                          SizedBox(width: 20 * scale),
                          Expanded(child: options),
                        ],
                      )
                    else ...[
                      questionCard,
                      SizedBox(height: 16 * scale),
                      options,
                    ],
                    SizedBox(height: 16 * scale),
                    numberBar,
                    SizedBox(height: 12 * scale),
                    buttons,
                  ],
                ),
              );
            } else {
              // Header & progres di atas, tombol di bawah tetap terlihat,
              // bagian tengah (soal + opsi) bisa di-scroll.
              Widget middle;
              if (isWide) {
                middle = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(child: questionCard),
                    ),
                    SizedBox(width: 20 * scale),
                    Expanded(child: SingleChildScrollView(child: options)),
                  ],
                );
              } else {
                middle = SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      questionCard,
                      SizedBox(height: 16 * scale),
                      options,
                    ],
                  ),
                );
              }

              content = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  SizedBox(height: 16 * scale),
                  progress,
                  SizedBox(height: 16 * scale),
                  Expanded(child: middle),
                  SizedBox(height: 12 * scale),
                  numberBar,
                  SizedBox(height: 12 * scale),
                  buttons,
                ],
              );
            }

            return Center(
              // Lebar konten maksimal 1100 supaya rapi di web
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20 * scale,
                    vertical: 12 * scale,
                  ),
                  child: content,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Header: tombol keluar, nama mapel + nomor soal, tombol tema.
  Widget _buildHeader(
    BuildContext context,
    QuizProvider quizProvider,
    double scale,
  ) {
    final colors = Theme.of(context).colorScheme;
    final total = quizProvider.questions.length;

    return Row(
      children: [
        SquareIconButton(
          icon: Icons.close_rounded,
          tooltip: 'Keluar',
          onPressed: () {
            // Ambil ScaffoldMessenger sebelum pop, lalu tampilkan SnackBar
            // di halaman mapel. Progres tetap tersimpan di provider.
            final messenger = ScaffoldMessenger.of(context);
            Navigator.pop(context);
            messenger.showSnackBar(
              const SnackBar(content: Text('Progres disimpan')),
            );
          },
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            children: [
              Text(
                quizProvider.selectedSubject!.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17 * scale,
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                ),
              ),
              Text(
                'Soal ${quizProvider.currentIndex + 1} dari $total',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13 * scale,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12 * scale),
        const ThemeToggleButton(),
      ],
    );
  }

  // Baris "Progres ... 2 terjawab · 20%" + progress bar.
  Widget _buildProgress(
    BuildContext context,
    QuizProvider quizProvider,
    double scale,
  ) {
    final colors = Theme.of(context).colorScheme;
    final total = quizProvider.questions.length;
    final answered = quizProvider.answeredCount;
    final percent = (answered / total * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Progres',
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              ),
            ),
            SizedBox(width: 12 * scale),
            // Expanded: teks kanan boleh turun baris kalau layarnya sempit
            Expanded(
              child: Text(
                '$answered terjawab · $percent%',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 13 * scale,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8 * scale),
        // ClipRRect membuat ujung progress bar membulat
        ClipRRect(
          borderRadius: BorderRadius.circular(8 * scale),
          child: LinearProgressIndicator(
            value: answered / total, // 0.0 sampai 1.0
            minHeight: 8 * scale,
            color: colors.primary,
            backgroundColor: colors.primaryContainer,
          ),
        ),
      ],
    );
  }

  // Kartu berisi nomor soal dan teks soal.
  Widget _buildQuestionCard(
    BuildContext context,
    QuizProvider quizProvider,
    double scale,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chip kecil "Soal 3"
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10 * scale,
              vertical: 4 * scale,
            ),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(8 * scale),
            ),
            child: Text(
              'Soal ${quizProvider.currentIndex + 1}',
              style: TextStyle(
                fontSize: 12 * scale,
                fontWeight: FontWeight.w700,
                color: colors.primary,
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            quizProvider.currentQuestion.question,
            style: TextStyle(
              fontFamily: 'BricolageGrotesque',
              fontWeight: FontWeight.w700,
              fontSize: 20 * scale,
              height: 1.3,
              color: colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  // Empat pilihan jawaban A–D.
  Widget _buildOptions(QuizProvider quizProvider, double scale) {
    final options = quizProvider.currentQuestion.options;

    final List<Widget> tiles = [];
    for (int i = 0; i < options.length; i++) {
      if (i > 0) tiles.add(SizedBox(height: 10 * scale));
      tiles.add(
        OptionTile(
          letter: letters[i],
          text: options[i],
          isSelected: quizProvider.selectedAnswer == i,
          onTap: () => quizProvider.selectAnswer(i),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tiles,
    );
  }

  // Tombol "Sebelumnya" dan "Berikutnya" / "Kirim Jawaban".
  Widget _buildButtons(
    BuildContext context,
    QuizProvider quizProvider,
    double scale,
  ) {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            text: 'Sebelumnya',
            icon: Icons.arrow_back_rounded,
            // null = nonaktif di soal pertama
            onPressed: quizProvider.isFirstQuestion
                ? null
                : quizProvider.previousQuestion,
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: quizProvider.isLastQuestion
              ? PrimaryButton(
                  text: 'Kirim Jawaban',
                  icon: Icons.send_rounded,
                  onPressed: () => _confirmSubmit(context, quizProvider),
                )
              : PrimaryButton(
                  text: 'Berikutnya',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: quizProvider.nextQuestion,
                ),
        ),
      ],
    );
  }

  // Dialog konfirmasi sebelum jawaban dikirim.
  void _confirmSubmit(BuildContext context, QuizProvider quizProvider) {
    final unanswered =
        quizProvider.questions.length - quizProvider.answeredCount;
    final hasEmpty = unanswered > 0;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(hasEmpty ? 'Masih ada soal kosong' : 'Kirim jawaban?'),
          content: Text(
            hasEmpty
                ? 'Ada $unanswered soal yang belum dijawab. Tetap kirim?'
                : 'Jawaban tidak bisa diubah setelah dikirim.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // tutup dialog
                // "Periksa lagi": lompat ke soal kosong pertama
                if (hasEmpty) {
                  quizProvider.goToQuestion(quizProvider.answers.indexOf(null));
                }
              },
              child: Text(hasEmpty ? 'Periksa lagi' : 'Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // tutup dialog
                quizProvider.submitQuiz();
                // pushReplacement: halaman kuis diganti halaman hasil,
                // jadi tombol back dari hasil tidak kembali ke kuis.
                Navigator.pushReplacementNamed(context, '/result');
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  // Tampilan kalau belum ada mapel yang dipilih.
  Widget _buildNoSubject(BuildContext context, double scale) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24 * scale),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Belum ada mata pelajaran yang dipilih.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      color: colors.onSurface,
                    ),
                  ),
                  SizedBox(height: 24 * scale),
                  PrimaryButton(
                    text: 'Pilih Mata Pelajaran',
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/subject'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
