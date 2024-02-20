import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../models/comment.dart';

class ApiService extends GetxService {
  final Dio _dio;
  final _cacheManager = DioCacheManager(CacheConfig());

  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiService(this._dio) {
    _dio.interceptors.add(_cacheManager.interceptor);
  }

  Future<List<Comment>> fetchComments() async {
    var options = buildCacheOptions(const Duration(hours: 1)); // Use cache

    try {
      final response = await _dio.get('$_baseUrl/comments', options: options);

      if (response.statusCode == 200) {
        return (response.data as List).map((comment) => Comment.fromJson(comment)).toList();
      } else {
        throw Exception('Failed to load comments (Server Error)');
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.other) {
        throw Exception('Connection Error. Please check your internet.');  
      } else {
        throw Exception('Error fetching comments'); 
      }
    }    
  }
}
