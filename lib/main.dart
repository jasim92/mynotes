import 'dart:js';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;

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
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      //initialize firebase using below code

      builder: (context, snapshot) {
        //this snapshot is type of async here
        // we can show loading message by knowing the state of snapshot
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //if the future has done its work then this user info will show
            //getting already signed in user using this code
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              // if user is null then show this
              devtools.log("user is  null");
              return const LoginView();
            }
          default:
            // if the future has not done then loading.. will show
            return const CircularProgressIndicator();
        }
      },
    );
  }
}



