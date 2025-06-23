import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/my_back_button.dart';
import 'package:the_wall/helper/helper_functions.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          // any errors
          if (snapshot.hasError) {
            displayMessageToUser('Something went wrong', context);
          }

          // show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData == null) {
            return const Text('No Data');
          }

          // get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25),
                child: Row(children: [MyBackButton()]),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    // get individula user
                    final user = users[index];

                    return ListTile(
                      title: Text(user['username']),
                      subtitle: Text(user['email']),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
