import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: "enter email"),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _pass,
            decoration: const InputDecoration(hintText: "enter password"),
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
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    devtools.log("Please choose strong password");
                  } else if (e.code == 'email-already-in-use') {
                    devtools.log("Email already in use");
                  } else if (e.code == 'invalid-email') {
                    devtools.log("invalid email");
                  } else {
                    devtools.log(e.code);
                  }
                } catch (e) {
                  devtools.log("Some bad happened");
                }
              },
              child: Title(color: Colors.green, child: const Text("Register"))),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login", (route) => false);
              },
              child: const Text("Already registered? Login here"))
        ],
      ),
    );
  }
}
