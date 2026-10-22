import 'package:flutter/material.dart';

// Menyimpan mode tema (terang/gelap) untuk seluruh aplikasi.
// Karena disimpan di provider (di atas MaterialApp), pilihan tema
// tidak hilang saat layar dirotasi atau pindah halaman.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // tema awal: terang

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  // Ganti terang <-> gelap, lalu beri tahu widget yang mendengarkan
  // supaya tampilannya dibangun ulang.
  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
