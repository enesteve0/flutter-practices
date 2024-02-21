// Dart imports:
import 'package:get/get.dart';

// Project imports:
import '../models/comment.dart';
import '../services/api_service.dart';

class CommentController extends GetxController {
  final _apiService = Get.find<ApiService>();
  final _comments = <Comment>[].obs;
  final _isLoading = false.obs;
  final _errorOccurred = false.obs;

  List<Comment> get comments => _comments.toList();
  bool get isLoading => _isLoading.value;
  bool get errorOccurred => _errorOccurred.value;

  @override
  void onReady() {
    super.onReady();
    fetchComments();
  }

  Future<void> fetchComments() async {
    _isLoading.value = true;
    _errorOccurred.value = false;
    try {
      _comments.assignAll(await _apiService.fetchComments());
    } catch (e) {
      _errorOccurred.value = true;
    } finally {
      _isLoading.value = false;
    }
  }
}