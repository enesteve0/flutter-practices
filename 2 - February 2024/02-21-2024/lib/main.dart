// Dart imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// Project imports:
import 'services/api_service.dart';
import 'screens/comment_page.dart';

void main() {
  Get.put(ApiService(Dio()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => CommentPage(),
      },
    );
  }
}