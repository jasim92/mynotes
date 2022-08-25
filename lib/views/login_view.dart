import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _pass;

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        //we need a FutureBuilder to process or initialize the firebase option then
        // after initialization it will show widgets
        //first perform future process and then show on widget
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
                //if the future has done its work then this column will show
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      decoration:
                          const InputDecoration(hintText: "enter user email"),
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      controller: _pass,
                      decoration: const InputDecoration(
                          hintText: "enter user password"),
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _pass.text;

                          try {
                            //to create user with firebase and await for the response by using keyword await
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            print(userCredential);
                          } on FirebaseAuthException catch(e)
                          {
                            if(e.code=='user-not-found')
                              {
                                print("User not found");
                              }
                            else if(e.code=='wrong-password'){
                              print("Wrong Password");
                            }
                          }
                          catch (e) {
                            print("something bad happened");
                            print(e.runtimeType);
                            print(e);
                          }
                        },
                        child: Title(
                            color: Colors.green, child: const Text("Login")))
                  ],
                );
              default:
                // if the future has not done then loading.. will show
                return const Text("Loading...");
            }
          },
        ));
  }
}
