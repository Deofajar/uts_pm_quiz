import 'package:flutter/material.dart';

// Deretan kotak nomor soal (1–10). Bisa ditap untuk lompat ke soal itu.
class QuestionNumberBar extends StatelessWidget {
  final int total; // jumlah soal
  final int currentIndex; // soal yang sedang dibuka
  final List<int?> answers; // jawaban per soal (null = belum dijawab)
  final ValueChanged<int> onTap; // dipanggil dengan indeks soal yang ditap

  const QuestionNumberBar({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.answers,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    // Buat satu kotak untuk setiap soal
    final List<Widget> boxes = [];
    for (int i = 0; i < total; i++) {
      final isCurrent = i == currentIndex;
      final isAnswered = i < answers.length && answers[i] != null;

      // Tentukan warna sesuai keadaan soal
      Color boxColor;
      Color numberColor;
      Color borderColor;
      if (isCurrent) {
        boxColor = colors.primary;
        numberColor = colors.onPrimary;
        borderColor = colors.primary;
      } else if (isAnswered) {
        boxColor = colors.primaryContainer;
        numberColor = colors.primary;
        borderColor = colors.primaryContainer;
      } else {
        boxColor = colors.surface;
        numberColor = colors.onSurfaceVariant;
        borderColor = colors.outline;
      }

      final status = isAnswered ? 'sudah dijawab' : 'belum dijawab';

      boxes.add(
        // Expanded: 10 kotak dibagi rata, jadi pas di layar sempit
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2 * scale),
            child: Semantics(
              label: 'Soal ${i + 1}, $status',
              onTap: () => onTap(i),
              button: true,
              selected: isCurrent,
              excludeSemantics: true,
              child: Material(
                color: boxColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8 * scale),
                  side: BorderSide(color: borderColor),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onTap(i),
                  child: SizedBox(
                    height: 40 * scale,
                    child: Center(
                      // FittedBox: angka mengecil kalau kotaknya sempit
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 13 * scale,
                            fontWeight: FontWeight.w700,
                            color: numberColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(children: boxes);
  }
}
