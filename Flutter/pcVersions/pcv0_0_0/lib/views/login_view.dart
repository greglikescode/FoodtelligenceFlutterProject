import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pogin\''),
      ),
      body: Column(
        children: [
          TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'top GEmail')),
          TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'pAssword')),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log('Going to main now!');
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/main/',
                  (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  devtools.log('User Not Found');
                } else if (e.code == 'wrong-password') {
                  devtools.log('Wrong Password');
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/register/',
                (route) => false,
              );
            },
            child: const Text(
                'Not registered yet? Register here for free V-Bucks!!!'),
          )
        ],
      ),
    );
  }
}