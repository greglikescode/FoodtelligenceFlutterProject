import 'package:flutter/material.dart';
import 'package:foodtelligence/constants/routes.dart';
import 'package:foodtelligence/services/auth/auth_exceptions.dart';
import 'package:foodtelligence/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';

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
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                print('THIS RIGHT HERE IS THE USER $user');
                if (user?.isEmailVerified ?? false) {
                  // Users email is verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    mainRoute,
                    (route) => false,
                  );
                } else {
                  // User's email is NOT verified!!!
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  'User doesn\'t exist!!!!!!!!!!!!!!',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  '"Incorrect Password bitch!" - Jesse',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Authentication error',
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
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
