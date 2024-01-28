import 'package:get/get.dart';

class Comment {
  final RxInt postId;
  final RxInt id;
  final RxString name;
  final RxString email;
  final RxString body;

  Comment({
    required int postId,
    required int id,
    required String name,
    required String email,
    required String body,
  })  : this.postId = RxInt(postId),
        this.id = RxInt(id),
        this.name = RxString(name),
        this.email = RxString(email),
        this.body = RxString(body);

  Comment.fromJson(Map<String, dynamic> json)
      : postId = RxInt(json['postId']),
        id = RxInt(json['id']),
        name = RxString(json['name']),
        email = RxString(json['email']),
        body = RxString(json['body']);
}