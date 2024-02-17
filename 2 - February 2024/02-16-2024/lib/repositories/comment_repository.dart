import '../models/comment.dart';
import '../services/api_service.dart';

class CommentRepository {
  final ApiService _apiService;

  CommentRepository(this._apiService);

  Future<List<Comment>> fetchComments() async {
    try {
      final response = await _apiService.fetchComments(); 
      return response;
    } catch (error) {
      throw Exception('Failed to fetch comments from repository'); 
    }
  }
}
