part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// --- Checking if there are any session 'user log in?'
class CheckSessionEvent extends AuthEvent {}

// ---------- AUTH EVENT ----------------
// ignore: must_be_immutable
class LoginEvent extends AuthEvent {
  String email;
  String password;
  LoginEvent(this.email, this.password);
}

// ignore: must_be_immutable
class SignUpEvent extends AuthEvent {
  String name;
  String email;
  String password;
  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}


