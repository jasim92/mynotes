import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  // to ensure widget flutter binding and then we need to initialize firebase options
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        //we need a FutureBuilder to process or initialize the firebase option then
        // after initialization it will show widgets
        //first perform future process and then show on widget
        //we are defining it here because we don't want to initialize firebase again and again
        body: FutureBuilder(
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
                if (user?.emailVerified ?? false) {
                  print("you are verified");
                } else {
                  print("you need to verify you email");
                }
                return const Text("Done");
                break;
              default:
                // if the future has not done then loading.. will show
                return const Text("Loading...");
            }
          },
        ));
  }
}
