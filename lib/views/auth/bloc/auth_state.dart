part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


// ---- ResultStates ----
class SuccessState extends AuthState{}
// ignore: must_be_immutable
class ErrorState extends AuthState{
  String msg;
  ErrorState(this.msg);
}


//-- is session available ? ----
// ignore: must_be_immutable
class AvailableSessionState extends AuthState {
  dynamic isSessionAvailable;
  AvailableSessionState(this.isSessionAvailable);
}