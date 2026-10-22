import 'package:flutter/material.dart';

// Satu pilihan jawaban (A/B/C/D). Dipakai 4 kali di halaman soal.
class OptionTile extends StatelessWidget {
  final String letter; // "A", "B", "C", atau "D"
  final String text; // isi pilihan jawaban
  final bool isSelected; // true kalau pilihan ini sedang dipilih
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    // Warna berubah tergantung terpilih atau tidak
    final tileColor = isSelected ? colors.primaryContainer : colors.surface;
    final borderColor = isSelected ? colors.primary : colors.outline;
    final borderWidth = isSelected ? 2 * scale : 1.5 * scale;
    final letterBoxColor = isSelected ? colors.primary : backgroundColor;
    final letterColor = isSelected ? colors.onPrimary : colors.onSurface;

    // Semantics: dibacakan pembaca layar sebagai pilihan (seperti radio button)
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: isSelected,
      label: 'Pilihan $letter: $text',
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: tileColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16 * scale),
          side: BorderSide(color: borderColor, width: borderWidth),
        ),
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 60 * scale),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14 * scale,
                vertical: 10 * scale,
              ),
              child: Row(
                children: [
                  // Kotak huruf A/B/C/D
                  Container(
                    width: 36 * scale,
                    height: 36 * scale,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: letterBoxColor,
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    // FittedBox: huruf mengecil kalau ukuran teks HP besar
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w800,
                          color: letterColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  // Teks pilihan; Expanded supaya bisa turun ke baris kedua
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                  // Ikon centang hanya muncul kalau terpilih
                  if (isSelected) ...[
                    SizedBox(width: 8 * scale),
                    Icon(
                      Icons.check_circle_rounded,
                      size: 22 * scale,
                      color: colors.primary,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
