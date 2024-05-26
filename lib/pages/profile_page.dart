import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
// logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.red,
              child: const Center(
                child: Text('Profile Page'),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: logout,
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    ));
  }
}
