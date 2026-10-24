import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';

// HALAMAN 5 (sementara): pembahasan. Akan diganti di sesi berikutnya.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    final result = context.watch<QuizProvider>().lastResult;

    // Contoh: "Matematika · 7 dari 10 benar"
    final summary = result == null
        ? 'Belum ada hasil kuis.'
        : '${result.subject.name} · ${result.correctCount} dari '
            '${result.totalQuestions} benar';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembahasan',
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
          child: Text(
            summary,
            style: TextStyle(fontSize: 16 * scale, color: colors.onSurface),
          ),
        ),
      ),
    );
  }
}
