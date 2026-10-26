import 'package:flutter/material.dart';

// Tombol filter berbentuk kapsul (misalnya "Benar · 8").
class FilterPill extends StatelessWidget {
  final String label;
  final bool isActive; // true kalau filter ini sedang dipilih
  final VoidCallback onTap;

  const FilterPill({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    // Pill aktif dibuat kontras (gelap di tema terang, terang di tema gelap)
    final backgroundColor = isActive ? colors.onSurface : colors.surface;
    final textColor = isActive ? colors.surface : colors.onSurface;
    // StadiumBorder = bentuk kapsul (ujung kiri & kanan setengah lingkaran)
    final shape = StadiumBorder(
      side: isActive ? BorderSide.none : BorderSide(color: colors.outline),
    );

    return Semantics(
      label: label,
      button: true,
      selected: isActive,
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: backgroundColor,
        shape: shape,
        child: InkWell(
          customBorder: shape,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40 * scale),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * scale,
                vertical: 8 * scale,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14 * scale,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w500,
                        color: textColor,
                      ),
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
