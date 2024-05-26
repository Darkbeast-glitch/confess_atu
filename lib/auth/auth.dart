import 'package:confess_atu/pages/onbarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class AuthPage extends StatelessWidget {
  final String locationName;
  const AuthPage({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is logged in

            if (snapshot.hasData) {
              return const HomePage();
            }

            // user is Not logged in
            else {
              return const OnBoardingPage();
            }
          }),
    );
  }
}
