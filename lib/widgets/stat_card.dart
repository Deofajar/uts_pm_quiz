import 'package:flutter/material.dart';

// Kartu kecil berisi satu angka statistik (Benar / Salah / Kosong).
class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int value;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      label: '$label: $value',
      excludeSemantics: true,
      child: Container(
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: colors.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris atas: ikon + label
            Row(
              children: [
                Icon(icon, size: 18 * scale, color: iconColor),
                SizedBox(width: 6 * scale),
                // Expanded + ellipsis supaya label tidak overflow
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8 * scale),
            // Angka besar; FittedBox mengecilkan angka kalau kartunya sempit
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                '$value',
                style: TextStyle(
                  fontFamily: 'BricolageGrotesque',
                  fontWeight: FontWeight.w800,
                  fontSize: 26 * scale,
                  color: colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
