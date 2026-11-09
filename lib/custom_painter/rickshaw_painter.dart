import 'package:material_ui/material_ui.dart';

class RickshawPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //calculate value here
    final Size(:width, :height) = size;

    //green roof react
    final greenRoofRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(width * 0.12, 0, width * 0.76, height * 0.28),
      topLeft: Radius.circular(width * 0.14),
      topRight: Radius.circular(width * 0.14),
    );

    //yellow color body value
    final YellowBodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, height * 0.24, width, height * 0.66),
      Radius.circular(width * 0.16),
    );

    //wheel value
    final wheelWidth = width * 0.18;
    final wheelHeight = height * 0.08;
    final wheelTop = height * 0.90;

    //create color here
    final grennRoofPaint = Paint()
      ..color = Color(0xFF15803D)
      ..style = PaintingStyle.fill;

    final blackWheekPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final yellowBodyColor = Paint()
      ..color = Color(0xFFFACC15)
      ..style = PaintingStyle.fill;

    final yellowBosyBorderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.035;

    //darw here

    canvas.drawRRect(greenRoofRect, grennRoofPaint);
    //left Wheel
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(width * 0.20, wheelTop, wheelWidth, wheelHeight),
        Radius.circular(width * 0.03),
      ),
      blackWheekPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(width * 0.62, wheelTop, wheelWidth, wheelHeight),
        Radius.circular(width * 0.03),
      ),
      blackWheekPaint,
    );

    //darw yellow body
    canvas.drawRRect(YellowBodyRect, yellowBodyColor);
    canvas.drawRRect(YellowBodyRect, yellowBosyBorderPaint);
  }

  @override
  bool shouldRepaint(RickshawPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(RickshawPainter oldDelegate) => false;
}
