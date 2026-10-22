import 'package:flutter/material.dart';

// Tombol utama selebar layar, dengan ikon opsional di belakang teks.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // null = tombol nonaktif
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 56 * scale,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 20 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * scale),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // Ikon hanya ditampilkan kalau diisi
            if (icon != null) ...[
              SizedBox(width: 8 * scale),
              Icon(icon, size: 20 * scale),
            ],
          ],
        ),
      ),
    );
  }
}
