import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import '../models/comment.dart';

class ApiService extends GetxService {
  final dio.Dio _dio;
  final DioCacheManager _cacheManager = DioCacheManager(CacheConfig());

  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _commentsEndpoint = '/comments';

  ApiService(this._dio) {
    _dio.interceptors.add(_cacheManager.interceptor);
  }

  Future<List<Comment>> fetchComments() async {
    final dio.Options options = buildCacheOptions(const Duration(hours: 1)); // Use cache

    try {
      final dio.Response? response = await _dio.get('$_baseUrl$_commentsEndpoint', options: options);

      if (response != null && response.statusCode == 200) {
        return (response.data as List).map((comment) => Comment.fromJson(comment)).toList();
      } else {
        throw Exception('Failed to load comments (Server Error)');
      }
    } on dio.DioError catch (e) {
      if (e.type == dio.DioErrorType.connectTimeout || e.type == dio.DioErrorType.other) {
        throw Exception('Connection Error. Please check your internet.');  
      } else {
        throw Exception('Error fetching comments'); 
      }
    }    
  }
}