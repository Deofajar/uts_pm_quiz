import 'package:flutter/material.dart';

// Model data untuk satu mata pelajaran.
// Semua field final dan constructor-nya const, sehingga objek Subject
// bisa langsung dipakai di dalam daftar const (lihat subject_data.dart).
class Subject {
  final String id;
  final String name;
  final IconData icon;
  final Color color; // warna khas mapel (untuk kotak ikon)

  const Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}
