import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodtelligence/views/login_view.dart'; // Imports login_view.dart to main so it can be used. Awesome!
import 'package:foodtelligence/views/register_view.dart';
import 'package:foodtelligence/views/verify_email_view.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';
// Now you have to say devtools.log to get the log function from dart B)
import 'dart:developer' as devtools show log;

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
              final user = FirebaseAuth.instance.currentUser;
              devtools.log(user.toString());

              // If there IS a user..
              if (user != null) {
                // And that users email is verified...
                if (user.emailVerified) {
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

enum MenuAction { logout }

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main UI'),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    devtools.log(shouldLogout.toString());
                    // If the user wanting to logout is TRUE...
                    if (shouldLogout) {
                      // Log that user out ;)
                      devtools.log('Logging user out! Going to login!');
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                      value: MenuAction.logout, child: Text('Logout')),
                ];
              },
            )
          ],
        ),
        body: const Text('Hello world!'));
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out there champ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log Out'),
          ),
        ],
      );
    },
    // Proofs against user dismissing dialogue without answering question.
  ).then((value) => value ?? false);
}
