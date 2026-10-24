import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_result.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/score_ring.dart';
import '../widgets/secondary_button.dart';
import '../widgets/square_icon_button.dart';
import '../widgets/stat_card.dart';
import '../widgets/theme_toggle_button.dart';

// HALAMAN 4: skor akhir.
// Cukup StatelessWidget karena hasil kuis sudah disimpan di QuizProvider
// (lastResult) saat jawaban dikirim di halaman soal.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  // Judul kartu skor, dipilih berdasarkan rentang skor.
  String _titleFor(int score, String name) {
    if (score == 100) {
      return 'Sempurna, $name!';
    } else if (score >= 80) {
      return 'Kerja bagus, $name!';
    } else if (score >= 60) {
      return 'Lumayan, $name!';
    } else {
      return 'Tetap semangat, $name!';
    }
  }

  // Kalimat penyemangat, juga berdasarkan rentang skor.
  String _messageFor(int score) {
    if (score == 100) {
      return 'Semua jawabanmu benar.';
    } else if (score >= 80) {
      return 'Sedikit lagi menuju skor sempurna.';
    } else if (score >= 60) {
      return 'Coba lihat pembahasan untuk soal yang salah.';
    } else {
      return 'Pelajari pembahasannya lalu coba lagi, ya.';
    }
  }

  // Kembali ke halaman mapel (menutup semua halaman di atasnya).
  void _backToSubjects(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/subject'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();

    final quizProvider = context.watch<QuizProvider>();
    final result = quizProvider.lastResult;

    // Belum ada hasil (mis. halaman dibuka langsung lewat URL di web)
    if (result == null) {
      return _buildNoResult(context, scale);
    }

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 720;
            final padding = EdgeInsets.symmetric(
              horizontal: 20 * scale,
              vertical: 16 * scale,
            );

            final header = _buildHeader(context, scale);
            final scoreCard = _buildScoreCard(
              context,
              result,
              quizProvider.userName,
              scale,
              size,
            );
            final stats = _buildStats(context, result, scale);
            final buttons = _buildButtons(context, quizProvider, result, scale);

            // ---------- Layar lebar: dua kolom ----------
            if (isWide) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        header,
                        SizedBox(height: 20 * scale),
                        Expanded(
                          child: Row(
                            children: [
                              // Kiri: kartu skor
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: scoreCard,
                                  ),
                                ),
                              ),
                              SizedBox(width: 24 * scale),
                              // Kanan: statistik + tombol
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        stats,
                                        SizedBox(height: 24 * scale),
                                        buttons,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // ---------- HP: satu kolom ----------
            return SingleChildScrollView(
              padding: padding,
              child: Center(
                child: ConstrainedBox(
                  // minHeight = tinggi layar, supaya Spacer bisa mendorong
                  // tombol ke bawah; kalau layar pendek, halaman di-scroll.
                  constraints: BoxConstraints(
                    maxWidth: 1100,
                    minHeight: max(0, constraints.maxHeight - padding.vertical),
                  ),
                  // IntrinsicHeight supaya Spacer bisa dipakai di dalam
                  // SingleChildScrollView.
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        header,
                        SizedBox(height: 20 * scale),
                        scoreCard,
                        SizedBox(height: 16 * scale),
                        stats,
                        const Spacer(),
                        SizedBox(height: 24 * scale),
                        buttons,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Header: tombol beranda, judul halaman, tombol tema.
  Widget _buildHeader(BuildContext context, double scale) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        SquareIconButton(
          icon: Icons.home_rounded,
          tooltip: 'Kembali ke beranda',
          onPressed: () => _backToSubjects(context),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Text(
            'Hasil Kuis',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17 * scale,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        const ThemeToggleButton(),
      ],
    );
  }

  // Kartu berwarna berisi lingkaran skor, judul, dan kalimat penyemangat.
  Widget _buildScoreCard(
    BuildContext context,
    QuizResult result,
    String userName,
    double scale,
    Size size,
  ) {
    final colors = Theme.of(context).colorScheme;
    // Diameter ±45% lebar layar, tapi maksimal 200 (dikali skala)
    final ringDiameter = min(size.width * 0.45, 200 * scale);
    // Cadangan kalau nama kosong (mis. halaman dibuka langsung di web)
    final name = userName.isEmpty ? 'kamu' : userName;

    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: colors.tertiary, // sama dengan warna HeroCard di Halaman 1
        borderRadius: BorderRadius.circular(28 * scale),
      ),
      child: Column(
        children: [
          ScoreRing(score: result.score, diameter: ringDiameter),
          SizedBox(height: 20 * scale),
          Text(
            _titleFor(result.score, name),
            textAlign: TextAlign.center,
            maxLines: 2, // nama panjang tidak overflow
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'BricolageGrotesque',
              fontWeight: FontWeight.w800,
              fontSize: 22 * scale,
              height: 1.2,
              color: colors.onTertiary,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'Kamu menyelesaikan kuis ${result.subject.name}. '
            '${_messageFor(result.score)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14 * scale,
              height: 1.4,
              color: colors.onTertiary,
            ),
          ),
        ],
      ),
    );
  }

  // Tiga kartu statistik: Benar, Salah, Kosong.
  Widget _buildStats(BuildContext context, QuizResult result, double scale) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Warna "benar" tidak ada di ColorScheme, jadi diambil dari AppColors
    final successColor = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.check_circle_rounded,
            iconColor: successColor,
            label: 'Benar',
            value: result.correctCount,
          ),
        ),
        SizedBox(width: 10 * scale),
        Expanded(
          child: StatCard(
            icon: Icons.cancel_rounded,
            iconColor: colors.error,
            label: 'Salah',
            value: result.wrongCount,
          ),
        ),
        SizedBox(width: 10 * scale),
        Expanded(
          child: StatCard(
            icon: Icons.radio_button_unchecked_rounded,
            iconColor: colors.onSurfaceVariant,
            label: 'Kosong',
            value: result.unansweredCount,
          ),
        ),
      ],
    );
  }

  // Tombol "Lihat Pembahasan", "Ulangi", dan "Mapel Lain".
  Widget _buildButtons(
    BuildContext context,
    QuizProvider quizProvider,
    QuizResult result,
    double scale,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          text: 'Lihat Pembahasan',
          icon: Icons.menu_book_rounded,
          onPressed: () => Navigator.pushNamed(context, '/review'),
        ),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                text: 'Ulangi',
                icon: Icons.replay_rounded,
                onPressed: () {
                  // Progres mapel ini sudah dihapus saat submit,
                  // jadi selectSubject membuat kuis baru dari soal 1.
                  quizProvider.selectSubject(result.subject);
                  Navigator.pushReplacementNamed(context, '/quiz');
                },
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: SecondaryButton(
                text: 'Mapel Lain',
                icon: Icons.grid_view_rounded,
                onPressed: () => _backToSubjects(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Tampilan kalau belum ada hasil kuis.
  Widget _buildNoResult(BuildContext context, double scale) {
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
                    'Belum ada hasil kuis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      color: colors.onSurface,
                    ),
                  ),
                  SizedBox(height: 24 * scale),
                  PrimaryButton(
                    text: 'Pilih Mata Pelajaran',
                    // Buka halaman mapel dan buang halaman lain di atas
                    // halaman pertama.
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/subject',
                      (route) => route.isFirst,
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
