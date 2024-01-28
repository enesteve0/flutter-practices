import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'controller.dart';
import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = Get.put(ApiService(Dio()));

  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CommentPage(),
    );
  }
}