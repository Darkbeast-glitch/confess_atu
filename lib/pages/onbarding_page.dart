import 'package:confess_atu/components/my_buttons.dart';
import 'package:confess_atu/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'register_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({
    super.key,
  });

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // chat imagee
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              "assets/images/chat.svg",
              height: 300,
              width: 300,
            ),

            // welcome text
            RichText(
              text: const TextSpan(
                text: "Welcome to ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Product Sans Bold",
                ),
                children: [
                  TextSpan(
                    text: "Confess ATU",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: "Product Sans Bold",
                    ),
                  ),
                ],
              ),
            ),

            // simple text
            Text(
              textAlign: TextAlign.center,
              "Confess ATU is a platform where you can \nconfess anonymously, chat with other students and get help from the community. Let see what's going on on campus",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
                fontFamily: "Product Sans Regular",
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // login button

            MyButton(
              text: "Login",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              color: Colors.black,
            ),

            // register button

            MyButton(
              text: "Register",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              color: const Color.fromARGB(255, 139, 135, 135),
            ),

            const SizedBox(
              height: 10,
            ),
            // Built by
            const Text(
              "\u00A9 Built by Julius Boakye",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: "Product Sans Regular",
              ),
            ),

            // terms and conditions
            const Text(
              "By continuing you agree to our Terms and Conditions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: "Product Sans Regular",
              ),
            ),

            // read guidelines
          ],
        ),
      ),
    );
  }
}
