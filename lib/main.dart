import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

import 'firebase_options.dart';

void main() {
  // to ensure widget flutter binding and then we need to initialize firebase options
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.orange,
    ),
    home: const HomePage(),
    routes: {
      "/login": (context) => const LoginView(),
      "/register": (context) => const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: //initialize firebase using below code
          Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        //this snapshot is type pf async here
        // we can show loading message by knowing the state of snapshot
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //if the future has done its work then this user info will show
            //getting already signed in user using this code
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print("email verified");
              } else {
                return const VerifyEmailView();
              }
            } else {
              // if user is null then show this
              return const LoginView();
            }
            return const Text("Done");
          default:
            // if the future has not done then loading.. will show
            return const Text("Loading...");
        }
      },
    );
  }
}
