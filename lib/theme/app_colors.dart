import 'package:flutter/material.dart';

// Semua warna aplikasi dikumpulkan di sini supaya mudah diubah.
// Widget tidak memakai warna ini langsung, tapi lewat
// Theme.of(context).colorScheme (lihat app_theme.dart).
class AppColors {
  // ===== Mode terang =====
  static const Color lightBackground = Color(0xFFF3F5FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF14172B);
  static const Color lightTextMuted = Color(0xFF5A5F7A);
  static const Color lightBorder = Color(0xFFDCE0EE);
  static const Color lightPrimary = Color(0xFF3B3FD8);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFE6E7FF);
  static const Color lightError = Color(0xFFC23B31);
  static const Color lightHeroCard = Color(0xFF3B3FD8);

  // ===== Mode gelap =====
  static const Color darkBackground = Color(0xFF0F1222);
  static const Color darkSurface = Color(0xFF1A1E36);
  static const Color darkText = Color(0xFFEEF0FA);
  static const Color darkTextMuted = Color(0xFFA3A8C3);
  static const Color darkBorder = Color(0xFF2C3150);
  static const Color darkPrimary = Color(0xFF8B8FFF);
  static const Color darkOnPrimary = Color(0xFF0F1222);
  static const Color darkPrimaryContainer = Color(0xFF262A5A);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkHeroCard = Color(0xFF262A5A);

  // ===== Warna "benar" (tidak ada di ColorScheme) =====
  static const Color lightSuccess = Color(0xFF1C7A45);
  static const Color darkSuccess = Color(0xFF4ADE80);

  // ===== Sama di kedua mode =====
  static const Color accent = Color(0xFFFFB547);
  static const Color white = Color(0xFFFFFFFF);
}
