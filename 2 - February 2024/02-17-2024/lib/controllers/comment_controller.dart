import 'package:get/get.dart';
import '../models/comment.dart';
import '../services/api_service.dart';

class CommentController extends GetxController {
  final ApiService _apiService = Get.find();
  final comments = <Comment>[].obs;
  final isLoading = false.obs;
  final errorOccurred = false.obs; // For error state

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  Future<void> fetchComments() async {
    isLoading.value = true;
    errorOccurred.value = false; // Reset error state
    try {
      comments.value = await _apiService.fetchComments();
    } catch (e) {
      errorOccurred.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
