import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: CustomCircularProgressIndicator(),
      ),
    ),
  ));
}

class CustomCircularProgressIndicator extends StatefulWidget {
  final double strokeWidth; // 원의 두께
  final Color color;        // 원의 색상

  CustomCircularProgressIndicator({this.strokeWidth = 10, this.color = Colors.blue});

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // 애니메이션 반복 실행
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.strokeWidth * 20,   // 원의 크기
      height: widget.strokeWidth * 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi, // 애니메이션 각도
            child: CustomPaint(
              painter: _CustomProgressPainter(
                strokeWidth: widget.strokeWidth,
                color: widget.color,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CustomProgressPainter extends CustomPainter {
  static const double startAngle = -math.pi / 2;          // 시작 각도 (12시 방향)
  static const double sweepAngle = math.pi * 2 * (2 / 3); // 원의 3분의 2 둘레에 해당하는 호의 각도
  final double strokeWidth;   // 원의 두께
  final Color color;          // 원의 색상

  _CustomProgressPainter({required this.strokeWidth, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2; // 원의 반지름

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2); // 원의 중심 좌표

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),  // 원 그리기 영역
      startAngle, // 시작 각도
      sweepAngle, // 호의 각도
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}