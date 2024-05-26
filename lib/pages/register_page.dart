import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_buttons.dart';
import '../components/mytext_field.dart';
import '../helper/helper_function.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // login function
  void registerUser() async {
    // show a loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog!
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20.0),
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
    //

    // check if the password and confirm password are the same
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);

      // show error to the user

      displayMessageToUser("Passwords dont' much", context);
      // show a snackbar
    } else {
      try {
        // create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordController.text);

        Navigator.pop(context);

        // send the user  to the login page to login
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );

        // delay the snacbar by a small amount of time to allow the navigation to complete

        Future.delayed(const Duration(milliseconds: 500), () {
          // show sunccess message with green bakcground

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Account created successfully"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ));
        });
      } on FirebaseAuthException catch (e) {
        // pop the circle
        Navigator.pop(context);

        // display message to the user
        displayMessageToUser(e.message!, context);
      }
    }
    // try creating user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
        centerTitle: true,
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
                "Create your Account.",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Product Sans Bold"),
              ),
              const SizedBox(height: 10),
              // welcome back you h'ave been missed text
              Text(
                "Hey there \nLet's get you on board",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w400,
                    fontFamily: "Product Sans Regular"),
              ),
              const SizedBox(height: 50),

              // email

              const Text("Email "),
              MyTextField(
                hintText: "Enter your  email",
                obsecureText: false,
                controller: emailcontroller,
              ),
              const SizedBox(height: 20),

              const Text("Password "),
              MyTextField(
                hintText: "Enter your password",
                obsecureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),

              const Text("Confrim Password"),
              // password textfield
              MyTextField(
                hintText: "re enter your password",
                obsecureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 20),

              // You don't have an account register

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // login button
              MyButton(
                text: "Create account",
                onTap: registerUser,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
