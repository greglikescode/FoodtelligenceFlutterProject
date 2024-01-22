import 'package:flutter/material.dart';
import 'package:foodtelligence/constants/routes.dart';
import 'package:foodtelligence/services/auth/auth_service.dart';
import 'package:foodtelligence/views/login_view.dart';
import 'package:foodtelligence/views/notes/main_view.dart';
import 'package:foodtelligence/views/notes/create_update_note_view.dart';
import 'package:foodtelligence/views/register_view.dart';
import 'package:foodtelligence/views/verify_email_view.dart';
import 'dart:developer' as devtools
    show
        log; // Now you have to say devtools.log to get the log function from dart B)

// Hello! I am a change in main

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Foodtelligencev0',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // HOW TO SELECT WHICH PAGE YOU ARE LOOKING AT
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainRoute: (context) => const MainView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;

              // If there IS a user..
              if (user != null) {
                // And that users email is verified...
                if (user.isEmailVerified) {
                  // Tell them they are verified :)
                  devtools.log('You are verified my good friend');
                  return const MainView();

                  // If user THAT EXISTS is NOT verifed...
                } else {
                  // Give them the verification screen >:(
                  return const VerifyEmailView();
                }
                // And if user DOES NOT EXIST...
              } else {
                // Take them to login where they can also register :D
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
