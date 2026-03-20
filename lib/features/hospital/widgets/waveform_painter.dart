import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final Color color;
  final bool isAlert;
  WaveformPainter({required this.color, this.isAlert = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height / 2);

    int segments = 10;
    double segmentWidth = size.width / segments;

    for (int i = 0; i < segments; i++) {
      double x = i * segmentWidth;
      double y = size.height / 2;

      if (isAlert) {
        if (i % 2 != 0)
          y -= 15;
        else
          y += 10;
      } else {
        if (i % 4 == 1) y -= 10;
        if (i % 4 == 2) y += 5;
      }
      path.lineTo(x + segmentWidth / 2, y);
      path.lineTo(x + segmentWidth, size.height / 2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
