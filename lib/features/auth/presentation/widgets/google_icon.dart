import 'package:flutter/material.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: const _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill;
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill;
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, w, h);

    // Blue section (horizontal bar + arc)
    final bluePath = Path()
      ..moveTo(w * 0.5, h * 0.4)
      ..lineTo(w * 0.96, h * 0.4)
      ..arcTo(rect, 0, 1.2, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(bluePath, bluePaint);

    // Green section (bottom arc)
    final greenPath = Path()
      ..arcTo(rect, 1.2, 1.5, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // Yellow section (left arc)
    final yellowPath = Path()
      ..arcTo(rect, 2.7, 1.5, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Red section (top arc)
    final redPath = Path()
      ..arcTo(rect, 4.2, 1.3, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(redPath, redPaint);

    // Center cutout to make it a letter "G"
    final whiteHolePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.28, whiteHolePaint);

    // Blue crossbar
    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(w * 0.48, h * 0.38, w * 0.98, h * 0.62),
      const Radius.circular(2),
    );
    canvas.drawRRect(barRect, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

