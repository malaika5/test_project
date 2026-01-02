import 'dart:math';

import 'package:flutter/material.dart';

class RingSegmentPainter extends CustomPainter {
  final int segments;
  final Color lineColor;
  final double strokeWidth;

  RingSegmentPainter({
    required this.segments,
    required this.lineColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final angleStep = (2 * pi) / segments;

    for (int i = 0; i < segments; i++) {
      final angle = angleStep * i;

      final start = Offset(
        center.dx + cos(angle) * (radius * 0.72),
        center.dy + sin(angle) * (radius * 0.72),
      );

      final end = Offset(
        center.dx + cos(angle) * (radius * 0.95),
        center.dy + sin(angle) * (radius * 0.95),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
