import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class ChefHatLogo extends StatelessWidget {
  const ChefHatLogo({
    super.key,
    this.size = 110,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.52, size * 0.52),
          painter: _ChefHatPainter(color: colors.accent),
        ),
      ),
    );
  }
}

class _ChefHatPainter extends CustomPainter {
  const _ChefHatPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Draw the puffy top folds of the chef hat
    final path = Path();

    // Start at bottom left of band
    final bandTop = h * 0.72;
    final bandBottom = h * 0.88;
    final bandLeft = w * 0.22;
    final bandRight = w * 0.78;

    // Left bulge
    path.moveTo(bandLeft, bandTop);
    path.cubicTo(
      w * 0.05,
      bandTop - h * 0.1,
      w * 0.05,
      h * 0.25,
      w * 0.28,
      h * 0.22,
    );

    // Center bulge (tallest)
    path.cubicTo(
      w * 0.35,
      0,
      w * 0.65,
      0,
      w * 0.72,
      h * 0.22,
    );

    // Right bulge
    path.cubicTo(
      w * 0.95,
      h * 0.25,
      w * 0.95,
      bandTop - h * 0.1,
      bandRight,
      bandTop,
    );

    canvas.drawPath(path, strokePaint);

    // Draw brim / base band
    final bandRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(bandLeft, bandTop, bandRight, bandBottom),
      Radius.circular(w * 0.04),
    );
    canvas.drawRRect(bandRect, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _ChefHatPainter oldDelegate) =>
      oldDelegate.color != color;
}

