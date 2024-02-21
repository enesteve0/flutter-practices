import 'package:dio/dio.dart';
import '../models/comment.dart';
import '../services/api_service.dart';

class CommentRepository {
  final ApiService _apiService;

  CommentRepository(this._apiService);

  Future<List<Comment>> fetchComments() async {
    try {
      final List<Comment> response = await _apiService.fetchComments();
      return response;
    } on DioError catch (dioError) {
      throw Exception('Failed to fetch comments from repository due to network error: ${dioError.message}');
    } catch (error) {
      throw Exception('Failed to fetch comments from repository due to unexpected error: ${error.toString()}');
    }
  }
}