import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/subject_data.dart';
import '../models/subject.dart';
import '../providers/quiz_provider.dart';
import '../widgets/info_banner.dart';
import '../widgets/square_icon_button.dart';
import '../widgets/subject_card.dart';
import '../widgets/theme_toggle_button.dart';
import '../widgets/user_avatar.dart';

// HALAMAN 2: memilih mata pelajaran.
// Cukup StatelessWidget karena tidak ada data yang berubah di dalam
// halaman ini sendiri; nama dan skor dibaca dari QuizProvider.
class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  // Teks kecil di bawah nama mapel pada kartu.
  String _subtitleFor(QuizProvider quizProvider, Subject subject) {
    // Kuis yang belum selesai: tampilkan jumlah soal yang sudah dijawab,
    // bukti bahwa progres tersimpan walaupun pindah halaman.
    if (quizProvider.isInProgress(subject.id)) {
      final answered = quizProvider.answeredCountOf(subject.id);
      return 'Lanjutkan · $answered/$questionsPerQuiz terjawab';
    }

    final score = quizProvider.lastScoreOf(subject.id);
    if (score == null) {
      return '$questionsPerQuiz soal · Belum dicoba';
    }
    return '$questionsPerQuiz soal · Terakhir $score';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    // context.watch: halaman dibangun ulang kalau data provider berubah
    final quizProvider = context.watch<QuizProvider>();

    // Faktor ukuran teks dari pengaturan HP (1.0 = normal)
    final textScale = MediaQuery.textScalerOf(context).scale(1);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Jumlah kolom grid menyesuaikan lebar layar
            int columnCount;
            if (constraints.maxWidth >= 1024) {
              columnCount = 4; // desktop/web
            } else if (constraints.maxWidth >= 600) {
              columnCount = 3; // tablet
            } else if (constraints.maxWidth > constraints.maxHeight) {
              columnCount = 3; // HP lanskap
            } else {
              columnCount = 2; // HP potret
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * scale,
                vertical: 16 * scale,
              ),
              child: Center(
                // Lebar konten maksimal 1100 supaya rapi di web
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(context, quizProvider.userName, scale),
                      SizedBox(height: 24 * scale),
                      Text(
                        'Mau belajar apa hari ini?',
                        style: TextStyle(
                          fontFamily: 'BricolageGrotesque',
                          fontWeight: FontWeight.w800,
                          fontSize: 28 * scale,
                          height: 1.15,
                          color: colors.onSurface,
                        ),
                      ),
                      SizedBox(height: 16 * scale),
                      const InfoBanner(
                        icon: Icons.schedule_rounded,
                        text: 'Tiap kuis berisi $questionsPerQuiz soal. '
                            'Jawaban bisa kamu ubah sebelum kuis dikirim.',
                      ),
                      SizedBox(height: 28 * scale),
                      _buildSectionTitle(colors, scale),
                      SizedBox(height: 14 * scale),
                      GridView.builder(
                        // shrinkWrap + NeverScrollable karena grid sudah
                        // berada di dalam SingleChildScrollView
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subjects.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columnCount,
                          crossAxisSpacing: 12 * scale,
                          mainAxisSpacing: 12 * scale,
                          // Tinggi kartu tetap (bukan rasio) supaya nama
                          // mapel 2 baris selalu muat
                          mainAxisExtent:
                              SubjectCard.cardHeight(scale, textScale),
                        ),
                        itemBuilder: (context, index) {
                          final subject = subjects[index];
                          return SubjectCard(
                            subject: subject,
                            subtitle: _subtitleFor(quizProvider, subject),
                            onTap: () {
                              // Tutup SnackBar "Progres disimpan" (kalau ada)
                              // supaya tidak menutupi tombol di halaman soal
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              // Simpan pilihan mapel, lalu buka halaman soal
                              context
                                  .read<QuizProvider>()
                                  .selectSubject(subject);
                              Navigator.pushNamed(context, '/quiz');
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Baris atas: avatar, sapaan + nama, tombol ganti nama, tombol tema.
  Widget _buildHeader(BuildContext context, String userName, double scale) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        UserAvatar(name: userName, size: 48 * scale),
        SizedBox(width: 12 * scale),
        // Expanded + ellipsis: nama yang panjang dipotong, tidak overflow
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo,',
                style: TextStyle(
                  fontSize: 13 * scale,
                  color: colors.onSurfaceVariant,
                ),
              ),
              Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8 * scale),
        SquareIconButton(
          icon: Icons.edit_rounded,
          tooltip: 'Ganti nama',
          // Kembali ke Halaman 1; nama tetap terisi dari provider
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: 8 * scale),
        const ThemeToggleButton(),
      ],
    );
  }

  // Baris "Mata Pelajaran" ... "6 pilihan"
  Widget _buildSectionTitle(ColorScheme colors, double scale) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Mata Pelajaran',
            style: TextStyle(
              fontSize: 17 * scale,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        Text(
          '${subjects.length} pilihan',
          style: TextStyle(
            fontSize: 13 * scale,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
