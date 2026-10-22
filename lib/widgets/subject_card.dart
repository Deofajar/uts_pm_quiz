import 'package:flutter/material.dart';

import '../models/subject.dart';

// Kartu satu mata pelajaran di grid Halaman 2.
class SubjectCard extends StatelessWidget {
  final Subject subject;
  final String subtitle; // contoh: "10 soal · Belum dicoba"
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.subtitle,
    required this.onTap,
  });

  // Tinggi kartu, dipakai sebagai mainAxisExtent di GridView.
  // Bagian tetap  : padding 16+16, ikon 48, jarak 14 + 4, cadangan 4 = 102
  // Bagian teks   : nama 2 baris (16 x 1.25 x 2 = 40) + subtitle
  //                 (12 x 1.4 ≈ 17), dibulatkan 60.
  // Bagian teks dikali textScale supaya tetap muat kalau ukuran huruf
  // di pengaturan HP diperbesar.
  static double cardHeight(double scale, double textScale) {
    return (102 + 60 * textScale) * scale;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(20 * scale);

    // Label untuk pembaca layar, mis. "Matematika, 10 soal, Belum dicoba".
    final semanticLabel = '${subject.name}, ${subtitle.replaceAll(' · ', ', ')}';

    return Semantics(
      label: semanticLabel,
      button: true,
      excludeSemantics: true, // pakai label di atas, bukan teks satu per satu
      onTap: onTap, // supaya tetap bisa ditekan lewat pembaca layar
      child: Material(
        color: colors.surface,
        clipBehavior: Clip.antiAlias, // ripple tidak keluar dari sudut
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: colors.outline), // border 1px
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kotak ikon: background warna mapel transparan 15%
                Container(
                  width: 48 * scale,
                  height: 48 * scale,
                  decoration: BoxDecoration(
                    color: subject.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  child: Icon(
                    subject.icon,
                    size: 26 * scale,
                    color: subject.color,
                  ),
                ),
                const Spacer(), // dorong teks ke bagian bawah kartu
                Text(
                  subject.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                    color: colors.onSurface,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12 * scale,
                    height: 1.4,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
