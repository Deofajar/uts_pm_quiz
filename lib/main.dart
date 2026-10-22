import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/name_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/subject_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    // MultiProvider dipasang paling atas (di atas MaterialApp) supaya
    // datanya bisa diakses semua halaman dan tidak hilang saat
    // layar dirotasi atau pindah halaman.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => QuizProvider()),
      ],
      child: const KuisinApp(),
    ),
  );
}

class KuisinApp extends StatelessWidget {
  const KuisinApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dibangun ulang setiap kali tema diganti
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Kuisin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      // Belum ada splash, jadi '/' langsung membuka Halaman 1.
      // Setelah splash dibuat: ganti '/' menjadi SplashScreen, lalu
      // splash pindah ke halaman nama dengan pushReplacementNamed('/name').
      initialRoute: '/',
      routes: {
        '/': (context) => const NameScreen(),
        '/name': (context) => const NameScreen(),
        '/subject': (context) => const SubjectScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/result': (context) => const ResultScreen(),
      },
    );
  }
}
