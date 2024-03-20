part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


// ---- ResultStates ----
class SignUpSuccessState extends AuthState{}
// ignore: must_be_immutable
class SignUpErrorState extends AuthState{
  String msg;
  SignUpErrorState(this.msg);
}

class LogInSuccessState extends AuthState{}
// ignore: must_be_immutable
class LogInErrorState extends AuthState{
   String msg;
   LogInErrorState(this.msg);
}

class LogOutSuccessState extends AuthState{}
// ignore: must_be_immutable
class LogOutErrorState extends AuthState{
   String msg;
   LogOutErrorState(this.msg);
}

//-- is session available ? ----
// ignore: must_be_immutable
class AvailableSessionState extends AuthState {
  dynamic isSessionAvailable;
  AvailableSessionState(this.isSessionAvailable);
}