import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/my_drawer.dart';
import 'package:the_wall/components/my_post_button.dart';
import 'package:the_wall/components/my_textfield.dart';
import 'package:the_wall/database/firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post a message if there is a message in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TheWall.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // TEXTFIELD BOX FOR USER TO TYPE
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                //textfield
                Expanded(
                  child: MyTextField(
                    hintText: 'Share something...',
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),

                // post button
                PostButton(onTap: postMessage),
              ],
            ),
          ),

          // Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // get all posts
              final posts = snapshot.data!.docs;

              // no data?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('No posts.. Post SOmething!'),
                  ),
                );
              }

              // return as list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // get each individual post
                    final post = posts[index];

                    // get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['Timestamp'];

                    // return as list tile
                    return Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ListTile(
                        title: Text(message),
                        subtitle: Text(userEmail),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
