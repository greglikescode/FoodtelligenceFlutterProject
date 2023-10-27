import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

// immutable means this class and all it's subclasses MUST HAVE VALUES THAT CANNOT CHANGE.
@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}