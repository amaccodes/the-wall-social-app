import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final void Function()? onTap;
  const PostButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 10),
        child: Center(child: Icon(Icons.done, color: Colors.white)),
      ),
    );
  }
}
