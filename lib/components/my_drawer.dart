import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // home tile
            children: [
              // drawer header
              DrawerHeader(
                child: Icon(Icons.favorite, color: Colors.white, size: 40),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home, size: 25, color: Colors.white),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // this is already the home screen so pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.person, size: 25, color: Colors.white),
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // this is already the home screen so pop the drawer
                    Navigator.pop(context);

                    // navigate to profile screen
                    Navigator.pushNamed(context, '/profile_screen');
                  },
                ),
              ),

              // users tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.people, size: 25, color: Colors.white),
                  title: const Text(
                    "Users",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    // this is already the home screen so pop the drawer
                    Navigator.pop(context);

                    // navigate to profile screen
                    Navigator.pushNamed(context, '/users_screen');
                  },
                ),
              ),
            ],
          ),

          // logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout, size: 25, color: Colors.white),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                // navigate to profile screen
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
