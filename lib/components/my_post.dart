import 'package:flutter/material.dart';

class MyPost extends StatelessWidget {
  final String message;
  final String userEmail;
  final String timeStamp;
  final List<String> likes;
  final String postId;

  const MyPost({
    super.key,
    required this.message,
    required this.userEmail,
    required this.timeStamp,
    required this.likes,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(userEmail, style: TextStyle(color: Colors.grey[500])),
              const Text(" • "),
              Text(timeStamp, style: TextStyle(color: Colors.grey[500])),
            ],
          ),
        ],
      ),
    );
  }
}
