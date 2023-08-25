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
  final double strokeWidth;
  final Color color;

  CustomCircularProgressIndicator({this.strokeWidth = 10, this.color = Colors.blue});

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _rotationAngle = 0.0;

  void _rotate() {
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _rotationAngle += 0.2; // 회전 속도
        if (_rotationAngle >= 2 * math.pi) {
          _rotationAngle -= 2 * math.pi;
        }
        _rotate();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _animation = Tween(begin: 0.0, end: 2 / 3).animate(_controller); // 2/3까지 애니메이션

    _rotate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.strokeWidth * 20,
      height: widget.strokeWidth * 20,
      child: Transform.rotate(
        angle: _rotationAngle,
        child: CustomPaint(
          painter: _CustomProgressPainter(
            strokeWidth: widget.strokeWidth,
            color: widget.color,
            progress: _animation.value,
          ),
        ),
      ),
    );
  }
}

class _CustomProgressPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double progress;

  _CustomProgressPainter(
      {required this.strokeWidth, required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // 끝 부분을 둥글게 처리

    final Offset center = Offset(size.width / 2, size.height / 2);

    final double sweepAngle = math.pi * 2 * (2 / 3); // 원의 3분의 2 둘레에 해당하는 호의 각도

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // 시작 각도 12시 방향
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
