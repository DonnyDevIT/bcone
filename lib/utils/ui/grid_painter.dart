import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final int cols;
  final int rows;
  final Color lineColor;
  final double strokeWidth;

  GridPainter({
    required this.cols,
    required this.rows,
    this.lineColor = Colors.grey,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final cellWidth = size.width / cols;
    final cellHeight = size.height / rows;

    // Linee verticali
    for (int i = 0; i <= cols; i++) {
      final x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Linee orizzontali
    for (int j = 0; j <= rows; j++) {
      final y = j * cellHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.cols != cols ||
        oldDelegate.rows != rows ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
