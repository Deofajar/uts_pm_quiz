import 'package:flutter/material.dart';

// Kotak informasi berwarna primary dengan ikon di sebelah kiri.
class InfoBanner extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoBanner({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(18 * scale),
      ),
      child: Row(
        children: [
          // Kotak kecil berisi ikon. Warnanya onPrimary: putih di tema
          // terang dan gelap tua di tema gelap, supaya ikon tetap kontras.
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: colors.onPrimary,
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: Icon(icon, size: 22 * scale, color: colors.primary),
          ),
          SizedBox(width: 12 * scale),
          // Expanded supaya teks panjang turun ke baris berikutnya
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
                color: colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
