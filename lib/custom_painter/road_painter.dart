import 'package:material_ui/material_ui.dart';

class RoadPainter extends CustomPainter {
  RoadPainter(this.offset);

  final double offset;

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;

    final line1X = width / 3;
    final line2X = (width / 3) * 2;

    const lineHeight = 28.0;
    const lineSpace = 24.0;
    const period = lineHeight + lineSpace;

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    double startY = -period + (offset % period);

    while (startY < height) {
      canvas.drawLine(
        Offset(line1X, startY),
        Offset(line1X, startY + lineHeight),
        linePaint,
      );
      canvas.drawLine(
        Offset(line2X, startY),
        Offset(line2X, startY + lineHeight),
        linePaint,
      );
      startY += period;
    }
  }

  @override
  bool shouldRebuildSemantics(RoadPainter oldDelegate) => false;

  @override
  bool shouldRepaint(RoadPainter old) => old.offset != offset;
}
