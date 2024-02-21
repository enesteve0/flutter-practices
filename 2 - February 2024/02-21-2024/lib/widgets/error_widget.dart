import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;

  CustomErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}