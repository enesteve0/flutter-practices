import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double width;
  final double value;
  final Color color;
  final Duration animationDuration;

  const CustomProgressBar({
    Key? key,
    required this.width,
    required this.value,
    this.color = Colors.blue,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 20.0, // Example height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: value),
          duration: animationDuration,
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            );
          },
        ),
      ),
    );
  }
}