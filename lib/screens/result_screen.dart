import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';

// HALAMAN HASIL (sementara): membaca lastResult dari QuizProvider.
// Akan diganti dengan halaman hasil + pembahasan di sesi berikutnya.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    final quizProvider = context.watch<QuizProvider>();
    final result = quizProvider.lastResult;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Kuis',
          style: TextStyle(
            fontFamily: 'BricolageGrotesque',
            fontWeight: FontWeight.w700,
            fontSize: 20 * scale,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24 * scale),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: result == null
                  // Belum ada hasil (mis. halaman dibuka langsung di web)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Belum ada hasil kuis.',
                          style: TextStyle(
                            fontSize: 16 * scale,
                            color: colors.onSurface,
                          ),
                        ),
                        SizedBox(height: 24 * scale),
                        PrimaryButton(
                          text: 'Pilih Mata Pelajaran',
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            '/subject',
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          quizProvider.userName,
                          style: TextStyle(
                            fontSize: 16 * scale,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          result.subject.name,
                          style: TextStyle(
                            fontFamily: 'BricolageGrotesque',
                            fontWeight: FontWeight.w800,
                            fontSize: 24 * scale,
                            color: colors.onSurface,
                          ),
                        ),
                        SizedBox(height: 16 * scale),
                        Text(
                          '${result.score}',
                          style: TextStyle(
                            fontFamily: 'BricolageGrotesque',
                            fontWeight: FontWeight.w800,
                            fontSize: 56 * scale,
                            color: colors.primary,
                          ),
                        ),
                        Text(
                          '${result.correctCount} dari '
                          '${result.questions.length} benar',
                          style: TextStyle(
                            fontSize: 16 * scale,
                            color: colors.onSurface,
                          ),
                        ),
                        SizedBox(height: 32 * scale),
                        PrimaryButton(
                          text: 'Kembali ke Mata Pelajaran',
                          // Tutup halaman sampai kembali ke halaman mapel
                          onPressed: () => Navigator.popUntil(
                            context,
                            ModalRoute.withName('/subject'),
                          ),
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
