import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pie Chart'),
        ),
        body: Center(
          child: PieChart(
            data: [
              PieData('Segment 1', 0.1, Colors.red),
              PieData('Segment 2', 0.3, Colors.green),
              PieData('Segment 3', 0.6, Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

class PieData {
  final String name;
  final double percent;
  final Color color;

  const PieData(this.name, this.percent, this.color);
}

class PieChart extends StatefulWidget {
  final List<PieData> data;

  const PieChart({Key? key, required this.data}) : super(key: key);

  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  int? activeIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (TapUpDetails details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final Offset localOffset = box.globalToLocal(details.globalPosition);
            final double radius = min(constraints.maxWidth, constraints.maxHeight) / 2;
            final Offset center = Offset(radius, radius);
            final double dx = localOffset.dx - center.dx;
            final double dy = localOffset.dy - center.dy;
            final double angle = atan2(dy, dx);
            final int index = (angle * widget.data.length / (2 * pi)).floor();
            setState(() {
              activeIndex = index;
            });
          },
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: _PieChartPainter(widget.data, activeIndex),
          ),
        );
      },
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<PieData> data;
  final int? activeIndex;

  _PieChartPainter(this.data, this.activeIndex);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = -pi / 2;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = data[i].percent * 2 * pi;
      final paint = Paint()..color = i == activeIndex ? data[i].color.withOpacity(0.9) : data[i].color;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(_PieChartPainter old) => old.activeIndex != activeIndex;
}