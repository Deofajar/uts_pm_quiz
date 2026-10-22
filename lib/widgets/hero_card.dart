import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Kartu berwarna berisi ilustrasi kuis (SVG).
// Kalau height tidak diisi, kartu mengikuti tinggi dari parent-nya.
class HeroCard extends StatelessWidget {
  final double? height;

  const HeroCard({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: colors.tertiary, // warna heroCard
        borderRadius: BorderRadius.circular(28 * scale),
      ),
      child: SvgPicture.asset(
        'assets/images/hero_quiz.svg',
        fit: BoxFit.contain, // gambar diperkecil/diperbesar tanpa terpotong
        semanticsLabel: 'Ilustrasi kartu soal pilihan ganda',
      ),
    );
  }
}
