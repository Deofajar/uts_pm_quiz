import 'package:flutter/material.dart';

// Kolom isian nama: label di atas, ikon orang di kiri,
// teks bantuan atau pesan error di bawah.
class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String helperText;
  final String? errorText; // kalau tidak null, kolom tampil merah
  final int maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted; // dipanggil saat tekan Enter/Done

  const NameTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.helperText,
    required this.maxLength,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(14 * scale);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14 * scale,
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
        SizedBox(height: 8 * scale),
        TextField(
          controller: controller,
          maxLength: maxLength,
          textInputAction: TextInputAction.done, // tombol "Done" di keyboard
          textCapitalization: TextCapitalization.words,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyle(fontSize: 16 * scale, color: colors.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            errorText: errorText,
            helperMaxLines: 2,
            errorMaxLines: 2,
            hintStyle: TextStyle(color: colors.onSurfaceVariant),
            helperStyle: TextStyle(
              fontSize: 12 * scale,
              color: colors.onSurfaceVariant,
            ),
            errorStyle: TextStyle(fontSize: 12 * scale, color: colors.error),
            prefixIcon: Icon(Icons.person_rounded, size: 22 * scale),
            prefixIconColor: colors.onSurfaceVariant,
            filled: true,
            fillColor: colors.surface,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16 * scale,
              vertical: 16 * scale,
            ),
            // Border untuk tiap keadaan: normal, fokus, dan error
            enabledBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colors.primary, width: 2 * scale),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: radius,
              borderSide: BorderSide(color: colors.error, width: 2 * scale),
            ),
          ),
        ),
      ],
    );
  }
}
