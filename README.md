# Kuisin – Aplikasi Kuis Pilihan Ganda

Tugas UTS Lab Pemrograman Mobile, Semester Ganjil T.A. 2026/2027.

## Identitas Mahasiswa

| |                                   |
|---|-----------------------------------|
| Nama | [Deofajar Jhonropinus Situmorang] |
| NIM | [241401102]                       |
| Lab | [5 (Pindahan LAB 6)]              |

## Informasi Aplikasi

**Nama Aplikasi:** Kuisin

**Deskripsi:**
Kuisin adalah aplikasi kuis pilihan ganda berbasis Flutter. Pengguna memasukkan nama, memilih salah satu dari enam mata pelajaran, lalu menjawab 10 soal pilihan ganda. Setelah jawaban dikirim, aplikasi menampilkan skor akhir beserta pembahasan setiap soal.

### Fitur Utama

1. **Halaman Masukkan Nama**
   - Input nama dengan validasi: tidak boleh kosong, minimal 2 huruf, maksimal 20 karakter. Pesan error tampil langsung di bawah kolom.
   - Kuis bisa dimulai dengan tombol "Mulai" atau tombol Enter/Done di keyboard.
   - Nama tersimpan di provider, jadi kolom tetap terisi saat pengguna kembali ke halaman ini.

2. **Halaman Pilih Mata Pelajaran**
   - Sapaan dengan avatar berisi huruf pertama nama, dan tombol "Ganti nama" untuk kembali ke halaman nama.
   - Enam mata pelajaran dalam bentuk grid: Matematika, Fisika, Biologi, Sejarah, Bahasa Inggris, dan Pengetahuan Umum.
   - Setiap kartu menampilkan status mapel: "Belum dicoba", "Lanjutkan · X/10 terjawab" (kuis belum dikirim), atau "Terakhir X" (skor terakhir).

3. **Halaman Soal**
   - Satu halaman (`QuizScreen`) menampilkan semua soal berdasarkan data, bukan satu file per soal.
   - Progress bar berisi jumlah soal terjawab dan persentasenya.
   - Empat pilihan jawaban (A–D). Jawaban bisa diganti selama kuis belum dikirim.
   - Deretan nomor soal 1–10 untuk lompat langsung ke soal tertentu. Warnanya membedakan soal aktif, sudah dijawab, dan belum dijawab.
   - Tombol "Sebelumnya" dan "Berikutnya". Di soal terakhir, tombol berubah menjadi "Kirim Jawaban".
   - Tombol "Keluar" kembali ke halaman mapel tanpa menghapus progres. Muncul SnackBar "Progres disimpan".

4. **Kirim Jawaban dengan Konfirmasi**
   - Kalau masih ada soal kosong, muncul dialog "Masih ada soal kosong" beserta jumlahnya. Tombol "Periksa lagi" langsung membuka soal kosong pertama.
   - Kalau semua soal sudah dijawab, muncul dialog "Kirim jawaban?" sebagai konfirmasi terakhir.

5. **Halaman Skor Akhir**
   - Lingkaran skor 0–100.
   - Judul dan kalimat penyemangat menyesuaikan skor (100, 80–99, 60–79, dan di bawah 60).
   - Ringkasan jumlah jawaban Benar, Salah, dan Kosong.
   - Tombol "Lihat Pembahasan", "Ulangi" (kuis mapel yang sama dimulai dari awal), "Mapel Lain", dan tombol beranda.

6. **Halaman Pembahasan**
   - Filter Semua, Benar, Salah, dan Kosong. Filter "Kosong" hanya muncul kalau ada soal yang tidak dijawab.
   - Setiap soal menampilkan jawaban pengguna dan status (benar/salah/tidak dijawab). Nomor soal tetap memakai nomor aslinya.
   - Untuk soal yang salah atau kosong, ditampilkan juga jawaban yang benar dan penjelasan singkatnya.

### Penerapan Kriteria UTS

| Kriteria | Penerapan di aplikasi | File terkait |
|---|---|---|
| StatelessWidget & StatefulWidget | **StatefulWidget** dipakai kalau halaman punya state lokal: `NameScreen` (isi kolom nama dan pesan error) dan `ReviewScreen` (filter yang sedang dipilih). **StatelessWidget** dipakai kalau datanya diambil dari provider: `SubjectScreen`, `QuizScreen`, `ResultScreen`, dan semua widget di `lib/widgets/`. | `lib/screens/name_screen.dart`, `lib/screens/review_screen.dart`, `lib/screens/subject_screen.dart`, `lib/screens/quiz_screen.dart`, `lib/screens/result_screen.dart` |
| Minimal 2 halaman + navigasi | Ada 5 halaman dengan named routes: `/` dan `/name` (Nama), `/subject` (Mapel), `/quiz` (Soal), `/result` (Skor), `/review` (Pembahasan). Navigasi memakai `pushNamed`, `pop`, `pushReplacementNamed` (setelah kirim jawaban, supaya tombol back tidak kembali ke kuis yang sudah selesai), dan `popUntil`. | `lib/main.dart`, `lib/screens/` |
| Reusable widget | Komponen yang dipakai berulang dibuat sebagai widget di file sendiri: `AppLogo`, `HeroCard`, `NameTextField`, `PrimaryButton`, `SecondaryButton`, `SquareIconButton`, `ThemeToggleButton`, `UserAvatar`, `InfoBanner`, `SubjectCard`, `OptionTile`, `QuestionNumberBar`, `ScoreRing`, `StatCard`, `FilterPill`, `ReviewCard`. | `lib/widgets/` |
| Aset gambar/ikon | Gambar SVG `logo.svg` dan `hero_quiz.svg` ditampilkan dengan package `flutter_svg`. Ikon memakai Material Icons versi rounded. | `assets/images/`, `lib/widgets/app_logo.dart`, `lib/widgets/hero_card.dart` |
| Font kustom | File TTF dibundel sebagai aset dan didaftarkan di `pubspec.yaml` (tanpa google_fonts): Plus Jakarta Sans (400, 600, 700, 800) untuk teks isi dan Bricolage Grotesque (700, 800) untuk judul. | `assets/fonts/`, `pubspec.yaml`, `lib/theme/app_theme.dart` |
| Ukuran dinamis | Setiap widget menghitung `scale = (shortestSide / 390).clamp(0.85, 1.3)` dari `MediaQuery`. Ukuran font, padding, radius, dan tinggi dikali `scale`. Beberapa ukuran memakai persentase layar, misalnya tinggi HeroCard ±30% tinggi layar dan diameter lingkaran skor ±45% lebar layar. | Semua file di `lib/screens/` dan `lib/widgets/` |
| State management | Memakai package `provider`. `ThemeProvider` menyimpan mode tema. `QuizProvider` menyimpan nama pengguna, mapel yang dipilih, jawaban dan nomor soal terakhir **per mapel**, hasil kuis terakhir (`lastResult`), dan skor terakhir per mapel. Kedua provider dipasang dengan `MultiProvider` di atas `MaterialApp`, jadi datanya tidak ikut hilang saat layar dirotasi atau halaman berganti. Itu sebabnya progres jawaban tetap ada setelah keluar lalu masuk lagi ke kuis. | `lib/main.dart`, `lib/providers/quiz_provider.dart`, `lib/providers/theme_provider.dart` |
| Tanpa database | Daftar mapel dan bank soal (6 mapel × 10 soal) disimpan sebagai data lokal (konstanta Dart). | `lib/data/subject_data.dart`, `lib/data/question_data.dart` |

### Fitur Bonus

**Dark & Light Mode**
- Tema terang dan gelap didefinisikan di `AppTheme`, dengan warna dari `AppColors`.
- Tema bisa diganti lewat tombol bulan/matahari di pojok kanan atas setiap halaman (Nama, Mapel, Soal, Skor, dan Pembahasan). Tema awalnya terang.
- Pilihan tema disimpan di `ThemeProvider`, jadi berlaku di semua halaman selama aplikasi berjalan.

**Layout Adaptif & Responsif**

Layout dipilih memakai `LayoutBuilder` berdasarkan lebar dan tinggi layar. Lebar konten dibatasi maksimal 1100 px (800 px untuk halaman Pembahasan) supaya tetap rapi di web.

| Halaman | HP potret | HP lanskap | Tablet / Web |
|---|---|---|---|
| Nama | Satu kolom, tombol "Mulai" di bawah | Dua kolom (ilustrasi di kiri, form di kanan) | Dua kolom (lebar ≥ 600) |
| Mapel | Grid 2 kolom | Grid 3 kolom | Grid 3 kolom (lebar 600–1023) atau 4 kolom (lebar ≥ 1024) |
| Soal | Satu kolom; header dan tombol tetap, soal di-scroll | Seluruh halaman di-scroll kalau tinggi < 500 | Dua kolom (soal di kiri, pilihan di kanan) kalau lebar ≥ 720 |
| Skor | Satu kolom | Satu kolom yang bisa di-scroll; dua kolom kalau lebar ≥ 720 | Dua kolom (kartu skor di kiri, statistik dan tombol di kanan) |
| Pembahasan | Header dan filter tetap, daftar soal di-scroll | Seluruh halaman di-scroll kalau tinggi < 500 | Konten di tengah, lebar maksimal 800 |

## Teknologi

- Flutter 3.47.6 (channel stable)
- Dart 3.13.5

| Package | Versi | Kegunaan |
|---|---|---|
| `provider` | 6.1.5+1 | State management (`ThemeProvider`, `QuizProvider`) |
| `flutter_svg` | 2.3.0 | Menampilkan gambar SVG (logo dan ilustrasi) |
| `cupertino_icons` | 1.0.9 | Bawaan template Flutter, tidak dipakai langsung di kode |
| `flutter_lints` (dev) | ^6.0.0 | Aturan analisis kode untuk `flutter analyze` |

## Cara Menjalankan

1. Pasang dependency:
   ```bash
   flutter pub get
   ```
2. Jalankan di emulator atau HP:
   ```bash
   flutter run
   ```
3. Jalankan di browser (Chrome):
   ```bash
   flutter run -d chrome
   ```

## Dokumentasi

### Credit Aset

| Aset | Sumber | Lisensi |
|---|---|---|
| Font Plus Jakarta Sans | Tokotype – [github.com/tokotype/PlusJakartaSans](https://github.com/tokotype/PlusJakartaSans) | SIL Open Font License 1.1 (`assets/fonts/OFL_PlusJakartaSans.txt`) |
| Font Bricolage Grotesque | Mathieu Triay – [github.com/ateliertriay/bricolage](https://github.com/ateliertriay/bricolage) | SIL Open Font License 1.1 (`assets/fonts/OFL_BricolageGrotesque.txt`) |
| Material Icons | Google – [fonts.google.com/icons](https://fonts.google.com/icons) | Apache License 2.0 |
| Ilustrasi `hero_quiz.svg` dan `logo.svg` | Dibuat sendiri | – |
| Package `provider` | [pub.dev/packages/provider](https://pub.dev/packages/provider) | MIT License |
| Package `flutter_svg` | [pub.dev/packages/flutter_svg](https://pub.dev/packages/flutter_svg) | MIT License |

### Screenshot

| Halaman | Tampilan |
|---|---|
| Masukkan Nama | <img width="1080" height="2424" alt="Screenshot_20261026_025938" src="https://github.com/user-attachments/assets/f0173499-1d48-494a-82e2-b8257ad861c2" />
 |
| Pilih Mata Pelajaran | <img src="screenshots/02-mapel.png" width="250"> |
| Soal | <img width="1080" height="2424" alt="Screenshot_20261026_030033" src="https://github.com/user-attachments/assets/9e70551a-1e86-4fa8-af9a-46d2a8075263" />
 |
| Skor Akhir |  |<img width="1080" height="2424" alt="Screenshot_20261026_030120" src="https://github.com/user-attachments/assets/398b58fd-1703-43b4-bb08-31ca2ce72d69" />

| Pembahasan | <img width="1080" height="2424" alt="Screenshot_20261026_030134" src="https://github.com/user-attachments/assets/c5a07b33-33a8-464d-8655-cfdd595fd57c" />
 |
| Mode Gelap | <img width="1080" height="2424" alt="Screenshot_20261026_030148" src="https://github.com/user-attachments/assets/e9b63f10-d6ba-42dd-986d-ecc8dfd8a89f" />
 |
| Tablet | <img width="1583" height="856" alt="Screenshot 2026-10-26 030624" src="https://github.com/user-attachments/assets/4f47df82-da84-498d-adc7-21bef942b61e" />
 |

### Link Mockup / Prototype

[LINK MOCKUP]

