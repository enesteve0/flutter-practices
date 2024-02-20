import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({Key? key, required this.comment}) : super(key: key);

  final Comment comment; 

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.name),
      subtitle: Text(comment.body), 
    );
  }
}
