import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';

// Kartu pembahasan untuk satu soal: soal, jawaban user, status,
// dan (kalau salah/kosong) jawaban yang benar beserta penjelasannya.
class ReviewCard extends StatelessWidget {
  final int number; // nomor soal asli (1–10)
  final Question question;
  final int? userAnswer; // null = tidak dijawab
  final bool isCorrect;

  const ReviewCard({
    super.key,
    required this.number,
    required this.question,
    required this.userAnswer,
    required this.isCorrect,
  });

  // Ubah indeks jadi teks opsi lengkap, mis. 2 -> "C. 1 1/2".
  // String.fromCharCode(65) = "A", 66 = "B", dst.
  String _optionText(int index) {
    return '${String.fromCharCode(65 + index)}. ${question.options[index]}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;
    // Warna latar halaman, dipakai untuk kotak nomor dan kotak penjelasan
    // supaya terlihat beda dari warna kartu.
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final successColor = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;

    final isAnswered = userAnswer != null;

    // Ikon status di kanan kartu
    IconData statusIcon;
    Color statusColor;
    String statusLabel;
    if (isCorrect) {
      statusIcon = Icons.check_circle_rounded;
      statusColor = successColor;
      statusLabel = 'Benar';
    } else if (isAnswered) {
      statusIcon = Icons.cancel_rounded;
      statusColor = colors.error;
      statusLabel = 'Salah';
    } else {
      statusIcon = Icons.radio_button_unchecked_rounded;
      statusColor = colors.onSurfaceVariant;
      statusLabel = 'Tidak dijawab';
    }

    final smallText = TextStyle(fontSize: 13 * scale, height: 1.4);

    return Container(
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: colors.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kiri: kotak nomor soal
          Container(
            width: 32 * scale,
            height: 32 * scale,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8 * scale),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$number',
                style: TextStyle(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                ),
              ),
            ),
          ),
          SizedBox(width: 12 * scale),

          // Tengah: soal, jawaban, dan pembahasan.
          // Expanded supaya teks panjang turun ke baris berikutnya.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  style: TextStyle(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                    color: colors.onSurface,
                  ),
                ),
                SizedBox(height: 8 * scale),

                // Jawaban user: hijau kalau benar, merah kalau salah
                if (isAnswered)
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Jawabanmu: ',
                          style: TextStyle(color: colors.onSurfaceVariant),
                        ),
                        TextSpan(
                          text: _optionText(userAnswer!),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isCorrect ? successColor : colors.error,
                          ),
                        ),
                      ],
                    ),
                    style: smallText,
                  )
                else
                  Text(
                    'Jawabanmu: Tidak dijawab',
                    style: smallText.copyWith(
                      fontStyle: FontStyle.italic,
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                // Kalau salah atau kosong: tampilkan kunci + penjelasan
                if (!isCorrect) ...[
                  SizedBox(height: 4 * scale),
                  Text(
                    'Jawaban benar: ${_optionText(question.correctIndex)}',
                    style: smallText.copyWith(
                      fontWeight: FontWeight.w700,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10 * scale),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    child: Text(
                      question.explanation,
                      style: TextStyle(
                        fontSize: 12.5 * scale,
                        height: 1.4,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8 * scale),

          // Kanan: ikon status + label untuk pembaca layar
          Semantics(
            container: true, // label jadi node tersendiri
            label: statusLabel,
            child: Icon(statusIcon, size: 22 * scale, color: statusColor),
          ),
        ],
      ),
    );
  }
}
