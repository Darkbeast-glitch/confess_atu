import 'package:confess_atu/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/my_buttons.dart';
import '../components/mytext_field.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login function
  void loginUser() async {
    // show a loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog!
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
    // sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordController.text);

      // pop loading circle
      if (context.mounted) Navigator.pop(context);

      // navigate to the homepage and replace the current route with it
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );

      // delay the snackbar by a small amount of time to allow the navigation to complete
      Future.delayed(Duration(milliseconds: 500), () {
        // show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully logged in'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green, // green for success
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      // display error message with red background
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red, // red for error
        ),
      );
      // pop the circle
      Navigator.pop(context);

      // display message to the user
      // displayMessageToUser(e.message!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Login", style),
          ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Let's Sign you in text
              const Text(
                "Let's Sign you in.",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Product Sans Bold"),
              ),
              const SizedBox(height: 10),
              // welcome back you h'ave been missed text
              Text(
                "Welcome back \nYou've been missed",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w400,
                    fontFamily: "Product Sans Regular"),
              ),
              const SizedBox(height: 20),

              // email textfield
              const Text(
                "Username or Password",
                style:
                    TextStyle(fontSize: 12, fontFamily: "Product Sans Regular"),
              ),
              const SizedBox(height: 5),

              MyTextField(
                hintText: "Enter your username or email",
                obsecureText: false,
                controller: emailcontroller,
              ),
              const SizedBox(height: 20),

              const Text(
                "Password",
                style:
                    TextStyle(fontSize: 12, fontFamily: "Product Sans Regular"),
              ),
              const SizedBox(height: 5),

              // password textfield
              MyTextField(
                hintText: "Enter your password",
                obsecureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),

              // Divider
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or"),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Sign in with")],
              ),
              const SizedBox(height: 50),

              // socials

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // google
                  Image.asset("assets/images/google.png",
                      width: 50, height: 50),

                  // linkdein
                  Image.asset(
                    "assets/images/link.png",
                    width: 40,
                    height: 40,
                  ),

                  //X(twitter)

                  Image.asset(
                    "assets/images/x.png",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // You don't have an account register

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Color.fromARGB(255, 68, 68, 68),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Product Sans Bold"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // login button
                  MyButton(
                    text: "Login",
                    onTap: loginUser,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
