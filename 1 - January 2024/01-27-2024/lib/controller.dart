import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api.dart';
import 'comment.dart';

class CommentPage extends StatelessWidget {
  final CommentController commentController = Get.put(CommentController(), permanent: true);

  CommentPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Obx(() {
        if (commentController.comments.isEmpty) {
          return Center(child: Text('Loading...'));
        } else {
          return ListView.builder(
            itemCount: commentController.comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(commentController.comments[index].name.value),
                subtitle: Text(commentController.comments[index].body.value),
              );
            },
          );
        }
      }),
    );
  }
}

class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  late ApiService apiService;

  void onInit() {
    super.onInit();
    apiService = Get.find<ApiService>();
    fetchComments();
  }

  void fetchComments() async {
    var fetchedComments = await apiService.fetchComments();
    comments.assignAll(fetchedComments);
  }
}