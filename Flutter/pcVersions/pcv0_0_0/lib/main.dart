// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtelligence/views/login_view.dart'; // Imports login_view.dart to main so it can be used. Awesome!
import 'package:foodtelligence/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // HOW TO SELECT WHICH PAGE YOU ARE LOOKING AT
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // THIS IS AN ANONYMOUS ROUTE

              // final user = FirebaseAuth.instance.currentUser;
              // // If users email verification CAN BE read as true or false do that.
              // // IF NOT then by default set to false, that way non users will always be false.
              // if (user?.emailVerified ?? false) {
              //   return const Center(
              //       child: Text('You are verified my good friend'));
              // } else {
              //   print('You are not verified buddy');

              //   // How the a new widget is pushed onto the screen.
              //   // Pretty much just builds a new page for you on an if statement.
              //   return const VerifyEmailView();
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
