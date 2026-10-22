import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Logo aplikasi: ikon kotak + tulisan "Kuisin".
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // Faktor skala: layar 390 px dianggap ukuran normal (1.0).
    final size = MediaQuery.of(context).size;
    final scale = (size.shortestSide / 390).clamp(0.85, 1.3).toDouble();
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: 36 * scale,
          height: 36 * scale,
        ),
        SizedBox(width: 10 * scale),
        // Flexible + ellipsis supaya teks tidak overflow di layar sempit
        Flexible(
          child: Text(
            'Kuisin',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'BricolageGrotesque',
              fontWeight: FontWeight.w800,
              fontSize: 22 * scale,
              color: colors.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
