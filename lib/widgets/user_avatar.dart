import 'package:flutter/material.dart';

// Lingkaran berisi huruf pertama nama pengguna.
class UserAvatar extends StatelessWidget {
  final String name;
  final double size; // diameter lingkaran (sudah dikali scale oleh pemanggil)

  const UserAvatar({super.key, required this.name, required this.size});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Ambil huruf pertama lalu jadikan huruf besar; "?" kalau nama kosong.
    final trimmedName = name.trim();
    final initial =
        trimmedName.isEmpty ? '?' : trimmedName.substring(0, 1).toUpperCase();

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.secondary, // accent #FFB547 di kedua tema
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        // Huruf mengikuti ukuran lingkaran, tidak ikut ukuran teks sistem,
        // supaya tidak keluar dari lingkaran.
        textScaler: TextScaler.noScaling,
        style: TextStyle(
          fontFamily: 'BricolageGrotesque',
          fontWeight: FontWeight.w800,
          fontSize: size * 0.45,
          color: colors.onSecondary, // #14172B di kedua tema
        ),
      ),
    );
  }
}
