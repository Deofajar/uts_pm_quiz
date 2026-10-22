import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'square_icon_button.dart';

// Tombol untuk mengganti tema terang/gelap.
// Ikon bulan saat tema terang, ikon matahari saat tema gelap.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil ThemeProvider; widget ini ikut dibangun ulang saat tema berubah.
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    return SquareIconButton(
      icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      tooltip: isDark ? 'Ganti ke mode terang' : 'Ganti ke mode gelap',
      onPressed: themeProvider.toggleTheme,
    );
  }
}
