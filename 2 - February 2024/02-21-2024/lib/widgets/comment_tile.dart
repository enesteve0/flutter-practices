import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.name, style: const TextStyle(color: Colors.black)),
      subtitle: Text(comment.body, style: const TextStyle(color: Colors.grey)),
    );
  }
}