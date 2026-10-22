import 'package:flutter/material.dart';

import '../models/subject.dart';

// Jumlah soal dalam satu kuis.
const int questionsPerQuiz = 10;

// Daftar mata pelajaran (data lokal/dummy, tanpa database).
// Kotak ikon di kartu memakai color dengan transparansi 15% sebagai
// background, jadi tetap cocok di tema terang maupun gelap.
const List<Subject> subjects = [
  Subject(
    id: 'matematika',
    name: 'Matematika',
    icon: Icons.calculate_rounded,
    color: Color(0xFF5B5FE8),
  ),
  Subject(
    id: 'fisika',
    name: 'Fisika',
    icon: Icons.science_rounded,
    color: Color(0xFFE08A1E),
  ),
  Subject(
    id: 'biologi',
    name: 'Biologi',
    icon: Icons.eco_rounded,
    color: Color(0xFF2E9E5B),
  ),
  Subject(
    id: 'sejarah',
    name: 'Sejarah',
    icon: Icons.account_balance_rounded,
    color: Color(0xFFD9534F),
  ),
  Subject(
    id: 'bahasa_inggris',
    name: 'Bahasa Inggris',
    icon: Icons.translate_rounded,
    color: Color(0xFF2F8FD0),
  ),
  Subject(
    id: 'pengetahuan_umum',
    name: 'Pengetahuan Umum',
    icon: Icons.lightbulb_rounded,
    color: Color(0xFF9B59D0),
  ),
];
