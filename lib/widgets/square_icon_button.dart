import 'dart:math';

import 'package:flutter/material.dart';

// Tombol kotak rounded berborder dengan ikon di tengah.
// Dipakai untuk tombol ganti tema dan tombol "Ganti nama".
class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip; // teks petunjuk + label untuk pembaca layar
  final VoidCallback? onPressed;

  const SquareIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    // Area sentuh minimal 48 px (pedoman aksesibilitas Material).
    final buttonSize = max(44 * scale, kMinInteractiveDimension);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12 * scale),
      side: BorderSide(color: colors.outline),
    );

    return Tooltip(
      message: tooltip,
      child: Material(
        color: colors.surface,
        shape: shape,
        child: InkWell(
          customBorder: shape, // efek ripple mengikuti sudut rounded
          onTap: onPressed,
          child: SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: Icon(icon, size: 22 * scale, color: colors.onSurface),
          ),
        ),
      ),
    );
  }
}
