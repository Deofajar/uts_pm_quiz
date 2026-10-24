import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// Lingkaran progres skor (0–100) dengan angka skor di tengahnya.
// Dipakai di atas kartu berwarna tertiary, jadi teksnya onTertiary (putih).
class ScoreRing extends StatelessWidget {
  final int score; // 0–100
  final double diameter; // ukuran lingkaran (sudah dikali scale)

  const ScoreRing({super.key, required this.score, required this.diameter});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;
    final strokeWidth = 14 * scale;

    return Semantics(
      label: 'Skor $score dari 100',
      excludeSemantics: true,
      child: SizedBox(
        width: diameter,
        height: diameter,
        // Stack: lingkaran di belakang, angka di depan (di tengah)
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: diameter,
              height: diameter,
              child: CircularProgressIndicator(
                value: score / 100, // 0.0 – 1.0
                strokeWidth: strokeWidth,
                strokeCap: StrokeCap.round, // ujung garis membulat
                color: AppColors.accent,
                backgroundColor: colors.onTertiary.withValues(alpha: 0.22),
              ),
            ),
            // Padding seukuran garis supaya angka tidak menimpa lingkaran;
            // FittedBox mengecilkan angka kalau ruangnya tidak cukup.
            Padding(
              padding: EdgeInsets.all(strokeWidth * 2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$score',
                      style: TextStyle(
                        fontFamily: 'BricolageGrotesque',
                        fontWeight: FontWeight.w800,
                        fontSize: diameter * 0.3,
                        height: 1.0,
                        color: colors.onTertiary,
                      ),
                    ),
                    Text(
                      'dari 100',
                      style: TextStyle(
                        fontSize: 13 * scale,
                        color: colors.onTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
