import 'package:flutter/material.dart';

import 'app_colors.dart';

// Tema terang dan gelap.
// Warna dimasukkan ke ColorScheme, jadi widget cukup membaca
// Theme.of(context).colorScheme tanpa perlu cek mode terang/gelap.
//
// Pemetaan warna khusus:
//   textMuted -> onSurfaceVariant
//   border    -> outline
//   heroCard  -> tertiary
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'PlusJakartaSans',
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightText,
      secondary: AppColors.accent,
      onSecondary: AppColors.lightText,
      tertiary: AppColors.lightHeroCard,
      onTertiary: AppColors.white,
      error: AppColors.lightError,
      onError: AppColors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
      onSurfaceVariant: AppColors.lightTextMuted,
      outline: AppColors.lightBorder,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightText,
      surfaceTintColor: AppColors.lightBackground,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'PlusJakartaSans',
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkText,
      secondary: AppColors.accent,
      onSecondary: AppColors.lightText,
      tertiary: AppColors.darkHeroCard,
      onTertiary: AppColors.white,
      error: AppColors.darkError,
      onError: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkTextMuted,
      outline: AppColors.darkBorder,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
      surfaceTintColor: AppColors.darkBackground,
      elevation: 0,
    ),
  );
}
