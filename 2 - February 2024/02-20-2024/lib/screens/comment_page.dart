import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/comment_controller.dart';
import '../widgets/comment_tile.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key}) : super(key: key);

  final CommentController commentController = Get.put(CommentController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: GetX<CommentController>(
        init: commentController, 
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorOccurred.value) {
            return const Center(child: Text('Error loading comments'));
          } else if (controller.comments.isEmpty) {
            return const Center(child: Text('No comments'));
          } else { 
            return ListView.builder( 
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                return CommentTile(comment: controller.comments[index]);
              },
            );
          }
        },
      ),
    );
  }
}
