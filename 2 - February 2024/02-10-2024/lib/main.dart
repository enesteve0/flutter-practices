import 'bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Animated Progress Bar',
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final progressValue = ValueNotifier<double>(0.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Custom Progress Bar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: progressValue,
              builder: (context, value, child) {
                return CustomProgressBar(
                  width: 300.0,
                  value: value,
                );
              },
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder<double>(
              valueListenable: progressValue,
              builder: (context, value, child) {
                return Slider(
                  value: value,
                  onChanged: (newValue) {
                    progressValue.value = newValue;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}