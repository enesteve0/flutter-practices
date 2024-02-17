import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'services/api_service.dart';
import 'screens/comment_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final apiService = Get.put(ApiService(Dio())); 

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CommentPage(),
    );
  }
}
