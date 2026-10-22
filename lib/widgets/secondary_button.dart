import 'package:flutter/material.dart';

// Tombol bergaris (outlined) yang serasi dengan PrimaryButton.
// Ikon opsional di depan teks. onPressed = null berarti tombol nonaktif.
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const SecondaryButton({
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
    final isEnabled = onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: 56 * scale, // sama dengan PrimaryButton
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          padding: EdgeInsets.symmetric(horizontal: 20 * scale),
          // Garis abu-abu saat nonaktif, warna primary saat aktif
          side: BorderSide(
            color: isEnabled ? colors.primary : colors.outline,
            width: 1.5 * scale,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * scale),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon hanya ditampilkan kalau diisi
            if (icon != null) ...[
              Icon(icon, size: 20 * scale),
              SizedBox(width: 8 * scale),
            ],
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
          ],
        ),
      ),
    );
  }
}
