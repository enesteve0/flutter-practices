import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'comment.dart';

class ApiService extends GetxService {
  Dio _dio;

  ApiService(this._dio);

  Future<List<Comment>> fetchComments() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/comments');

    List<Comment> comments = [];
    if (response.statusCode == 200) {
      var commentData = response.data as List;
      for (var comment in commentData) {
        comments.add(Comment.fromJson(comment));
      }
    }
    return comments;
  }
}