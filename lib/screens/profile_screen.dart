import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/my_back_button.dart';
import 'package:the_wall/components/my_post.dart';
import 'package:the_wall/helper/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // error
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          // data recieved
          else if (snapshot.hasData) {
            //extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return Column(
              children: [
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Row(children: [MyBackButton()]),
                ),

                const SizedBox(height: 25),
                //profile picture
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // username
                Text(
                  user!['username'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // email
                Text(user['email']),

                // user posts
                ProfilePostsList(userEmail: user['email']),
              ],
            );
          } else {
            return const Text('No Data');
          }
        },
      ),
    );
  }
}

class ProfilePostsList extends StatefulWidget {
  final String userEmail;
  const ProfilePostsList({super.key, required this.userEmail});

  @override
  State<ProfilePostsList> createState() => _ProfilePostsListState();
}

class _ProfilePostsListState extends State<ProfilePostsList> {
  static const int pageSize = 10;
  List<DocumentSnapshot> posts = [];
  bool isLoading = false;
  bool hasMore = true;
  DocumentSnapshot? lastDocument;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    if (isLoading || !hasMore) return;
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      Query query = FirebaseFirestore.instance
          .collection('Posts')
          .where('UserEmail', isEqualTo: widget.userEmail)
          .orderBy('Timestamp', descending: true)
          .limit(pageSize);
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }
      final snapshot = await query.get();
      if (snapshot.docs.length < pageSize) hasMore = false;
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
        posts.addAll(snapshot.docs);
      }
    } catch (e) {
      error = e.toString();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.all(25),
        child: Center(child: Text('Error: $error')),
      );
    }
    if (posts.isEmpty && isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (posts.isEmpty) {
      return const Center(child: Text('No posts yet.'));
    }
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final data = posts[index].data() as Map<String, dynamic>;
            String message = data['PostMessage'] ?? '';
            String userEmail = data['UserEmail'] ?? '';
            Timestamp timeStamp = data['Timestamp'] ?? Timestamp.now();
            return Padding(
              padding: const EdgeInsets.only(left: 25, top: 8, right: 25),
              child: ListTile(
                title: Text(message),
                subtitle: Text(userEmail),
                trailing: Text(formatData(timeStamp)),
              ),
            );
          },
        ),
        if (hasMore)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: isLoading ? null : fetchPosts,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Load More'),
            ),
          ),
      ],
    );
  }
}
