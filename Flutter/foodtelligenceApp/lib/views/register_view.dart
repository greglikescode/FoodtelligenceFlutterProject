import 'package:flutter/material.dart';
import 'package:foodtelligence/constants/routes.dart';
import 'package:foodtelligence/services/auth/auth_exceptions.dart';
import 'package:foodtelligence/services/auth/auth_service.dart';
import 'package:foodtelligence/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
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
        title: const Text('Sex Offender Register!'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'top GEmail',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'pAssword',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  '"Password needs to hit the gym, its weak." - probably Arnold',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'Dude, that emails already being used. You\'ll have to contact support if that\'s a problem...',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'Email is invalid, noob.',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Failed to register due to an unkown error. LOL. TOUCH SOME KIDS TO GET ON THE SEX OFFENDER REGISTER',
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already Registered? LOGIN BUDDY!!!!!!!!!'),
          )
        ],
      ),
    );
  }
}
