import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quiz_result.dart';
import '../providers/quiz_provider.dart';
import '../widgets/filter_pill.dart';
import '../widgets/primary_button.dart';
import '../widgets/review_card.dart';
import '../widgets/square_icon_button.dart';
import '../widgets/theme_toggle_button.dart';

// Pilihan filter di halaman pembahasan.
enum ReviewFilter { semua, benar, salah, kosong }

// HALAMAN 5: pembahasan soal.
// Memakai StatefulWidget karena filter yang sedang dipilih adalah state
// LOKAL halaman ini (tidak perlu disimpan di provider). Hasil kuisnya
// tetap dibaca dari QuizProvider.lastResult.
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ReviewFilter _filter = ReviewFilter.semua; // filter awal: semua soal

  // Mengembalikan indeks soal (0–9) yang lolos filter aktif.
  // Indeks asli disimpan supaya nomor soal di kartu tetap nomor aslinya.
  List<int> _filteredIndexes(QuizResult result) {
    final List<int> indexes = [];
    for (int i = 0; i < result.totalQuestions; i++) {
      final answered = result.isAnswered(i);
      final correct = result.isCorrect(i);

      bool include;
      if (_filter == ReviewFilter.benar) {
        include = correct;
      } else if (_filter == ReviewFilter.salah) {
        include = answered && !correct; // dijawab tapi salah
      } else if (_filter == ReviewFilter.kosong) {
        include = !answered;
      } else {
        include = true; // semua
      }

      if (include) indexes.add(i);
    }
    return indexes;
  }

  // Ganti filter, lalu bangun ulang halaman.
  void _changeFilter(ReviewFilter filter) {
    setState(() {
      _filter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();

    final result = context.watch<QuizProvider>().lastResult;

    // Belum ada hasil (mis. halaman dibuka langsung lewat URL di web)
    if (result == null) {
      return _buildNoResult(context, scale);
    }

    final indexes = _filteredIndexes(result);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 720;
            // Layar pendek (mis. HP lanskap): header & filter ikut di-scroll
            // supaya daftar soal tetap punya ruang.
            final isShort = constraints.maxHeight < 500;
            final horizontalPadding = (isWide ? 32 : 20) * scale;

            // Bagian atas: header + filter
            final topSection = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, result, scale),
                SizedBox(height: 16 * scale),
                _buildFilters(result, scale),
                SizedBox(height: 16 * scale),
              ],
            );

            Widget content;
            if (isShort) {
              // Semua isi dalam satu scroll
              content = SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    topSection,
                    if (indexes.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24 * scale),
                        child: _buildEmptyText(context, scale),
                      )
                    else
                      for (final index in indexes)
                        Padding(
                          padding: EdgeInsets.only(bottom: 12 * scale),
                          child: _buildCard(result, index),
                        ),
                  ],
                ),
              );
            } else {
              // Header & filter tetap di atas, hanya daftar soal yang scroll
              content = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  topSection,
                  Expanded(
                    child: indexes.isEmpty
                        ? Center(child: _buildEmptyText(context, scale))
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 16 * scale),
                            itemCount: indexes.length,
                            itemBuilder: (context, position) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12 * scale),
                                child: _buildCard(result, indexes[position]),
                              );
                            },
                          ),
                  ),
                ],
              );
            }

            return Center(
              // Lebar maksimal 800 supaya kartu enak dibaca di tablet/web
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: 16 * scale,
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

  // Header: tombol kembali, judul + ringkasan, tombol tema.
  Widget _buildHeader(BuildContext context, QuizResult result, double scale) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        SquareIconButton(
          icon: Icons.arrow_back_rounded,
          tooltip: 'Kembali',
          onPressed: () => Navigator.pop(context), // ke halaman skor
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pembahasan',
                style: TextStyle(
                  fontSize: 17 * scale,
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                ),
              ),
              Text(
                '${result.subject.name} · ${result.correctCount} dari '
                '${result.totalQuestions} benar',
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

  // Deretan pill filter. Wrap: kalau tidak muat, pill turun ke baris baru.
  Widget _buildFilters(QuizResult result, double scale) {
    return Wrap(
      spacing: 8 * scale,
      runSpacing: 8 * scale,
      children: [
        FilterPill(
          label: 'Semua · ${result.totalQuestions}',
          isActive: _filter == ReviewFilter.semua,
          onTap: () => _changeFilter(ReviewFilter.semua),
        ),
        FilterPill(
          label: 'Benar · ${result.correctCount}',
          isActive: _filter == ReviewFilter.benar,
          onTap: () => _changeFilter(ReviewFilter.benar),
        ),
        FilterPill(
          label: 'Salah · ${result.wrongCount}',
          isActive: _filter == ReviewFilter.salah,
          onTap: () => _changeFilter(ReviewFilter.salah),
        ),
        // Pill "Kosong" hanya muncul kalau ada soal yang tidak dijawab
        if (result.unansweredCount > 0)
          FilterPill(
            label: 'Kosong · ${result.unansweredCount}',
            isActive: _filter == ReviewFilter.kosong,
            onTap: () => _changeFilter(ReviewFilter.kosong),
          ),
      ],
    );
  }

  // Satu kartu pembahasan; nomor soal memakai nomor asli (index + 1).
  Widget _buildCard(QuizResult result, int index) {
    return ReviewCard(
      number: index + 1,
      question: result.questions[index],
      userAnswer: result.answers[index],
      isCorrect: result.isCorrect(index),
    );
  }

  Widget _buildEmptyText(BuildContext context, double scale) {
    return Text(
      'Tidak ada soal di kategori ini.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14 * scale,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
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
