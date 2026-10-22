import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/hero_card.dart';
import '../widgets/name_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle_button.dart';

// HALAMAN 1: pengguna memasukkan nama sebelum memulai kuis.
// Memakai StatefulWidget karena halaman ini punya data yang berubah
// di dalam halaman itu sendiri: isi kolom nama dan pesan error.
class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  static const int maxNameLength = 20;

  final TextEditingController _nameController = TextEditingController();
  String? _errorText; // null artinya tidak ada error

  @override
  void initState() {
    super.initState();
    // Isi ulang kolom dengan nama yang sudah tersimpan di provider,
    // supaya nama tidak hilang saat pengguna kembali ke halaman ini.
    // listen: false karena di initState kita hanya membaca sekali.
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    _nameController.text = quizProvider.userName;
  }

  @override
  void dispose() {
    // Controller wajib di-dispose supaya tidak bocor memori.
    _nameController.dispose();
    super.dispose();
  }

  // Cek nama. Mengembalikan pesan error, atau null kalau nama valid.
  String? _validateName(String input) {
    final name = input.trim();
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (name.length < 2) {
      return 'Nama minimal 2 huruf';
    }
    if (name.length > maxNameLength) {
      return 'Nama maksimal $maxNameLength karakter';
    }
    return null;
  }

  // Dipanggil oleh tombol "Mulai" dan tombol Enter/Done di keyboard.
  void _submit() {
    final error = _validateName(_nameController.text);

    // setState supaya pesan error tampil/hilang di layar
    setState(() {
      _errorText = error;
    });

    if (error != null) return; // berhenti kalau nama belum valid

    Provider.of<QuizProvider>(context, listen: false)
        .setUserName(_nameController.text);
    FocusScope.of(context).unfocus(); // tutup keyboard
    Navigator.pushNamed(context, '/subject');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final horizontalPadding = 20 * scale;
    final verticalPadding = 16 * scale;

    return Scaffold(
      body: SafeArea(
        // LayoutBuilder memberi tahu ruang yang tersedia untuk halaman ini
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Layout dua kolom untuk HP lanskap atau layar lebar.
            final isWide = constraints.maxWidth >= 600 ||
                constraints.maxWidth > constraints.maxHeight;

            // Lebar konten dibatasi maksimal 1100 supaya rapi di web.
            final contentWidth = min(
              constraints.maxWidth - horizontalPadding * 2,
              1100.0,
            );

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  // minHeight = tinggi layar, supaya Spacer bisa mendorong
                  // tombol ke bawah. Saat keyboard muncul, halaman bisa
                  // di-scroll sehingga tidak overflow.
                  constraints: BoxConstraints(
                    maxWidth: 1100,
                    minHeight: max(
                      0,
                      constraints.maxHeight - verticalPadding * 2,
                    ),
                  ),
                  // IntrinsicHeight membuat Column setinggi isinya, sehingga
                  // Spacer bisa dipakai di dalam SingleChildScrollView.
                  child: IntrinsicHeight(
                    child: isWide
                        ? _buildWideLayout(scale, contentWidth)
                        : _buildPortraitLayout(scale, size),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // HP potret: semua isi dalam satu kolom.
  Widget _buildPortraitLayout(double scale, Size size) {
    // Tinggi kartu ±30% tinggi layar, dibatasi 180–300 (dikali skala).
    final heroHeight =
        (size.height * 0.30).clamp(180 * scale, 300 * scale).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(scale),
        SizedBox(height: 20 * scale),
        HeroCard(height: heroHeight),
        SizedBox(height: 28 * scale),
        _buildTitle(scale, 30 * scale),
        SizedBox(height: 24 * scale),
        _buildNameField(),
        const Spacer(), // dorong tombol ke bagian bawah layar
        SizedBox(height: 24 * scale),
        _buildStartButton(),
      ],
    );
  }

  // HP lanskap & layar lebar: kartu di kiri, form di kanan.
  Widget _buildWideLayout(double scale, double contentWidth) {
    final gap = 32 * scale;
    // Lebar kolom kanan: setengah sisa ruang, maksimal 440.
    final formWidth = min(440.0, (contentWidth - gap) * 0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(scale),
        SizedBox(height: 24 * scale),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kartu mengisi sisa lebar dan seluruh tinggi baris
              const Expanded(child: HeroCard()),
              SizedBox(width: gap),
              SizedBox(
                width: formWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTitle(scale, 26 * scale),
                    SizedBox(height: 24 * scale),
                    _buildNameField(),
                    SizedBox(height: 28 * scale),
                    _buildStartButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Baris paling atas: logo di kiri, tombol tema di kanan.
  Widget _buildHeader(double scale) {
    return Row(
      children: [
        const Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppLogo(),
          ),
        ),
        SizedBox(width: 12 * scale),
        const ThemeToggleButton(),
      ],
    );
  }

  // Judul dan subjudul halaman.
  Widget _buildTitle(double scale, double titleSize) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uji pemahamanmu, satu soal sekali waktu.',
          style: TextStyle(
            fontFamily: 'BricolageGrotesque',
            fontWeight: FontWeight.w800,
            fontSize: titleSize,
            height: 1.15,
            color: colors.onSurface,
          ),
        ),
        SizedBox(height: 10 * scale),
        Text(
          'Pilih mata pelajaran, jawab 10 soal pilihan ganda, '
          'lalu lihat skormu di akhir.',
          style: TextStyle(
            fontSize: 15 * scale,
            height: 1.5,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return NameTextField(
      controller: _nameController,
      label: 'Nama kamu',
      hint: 'Contoh: Blessy',
      helperText: 'Namamu akan muncul di halaman skor akhir.',
      errorText: _errorText,
      maxLength: maxNameLength,
      // Hapus pesan error begitu pengguna mengetik lagi
      onChanged: (value) {
        if (_errorText != null) {
          setState(() {
            _errorText = null;
          });
        }
      },
      onSubmitted: (value) => _submit(),
    );
  }

  Widget _buildStartButton() {
    return PrimaryButton(
      text: 'Mulai',
      icon: Icons.arrow_forward_rounded,
      onPressed: _submit,
    );
  }
}
