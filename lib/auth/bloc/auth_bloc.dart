// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:public_chat_app/services/database_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final serviceLocator = GetIt.I.get<DBService>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    // Session availability
    on<CheckSessionEvent>(redirect);

    // Log in Event
    on<LoginEvent>(login);

    // Sign up Event
    on<SignUpEvent>(signUp);

    // Sign Out Event
    on<LogoutEvent>(logOut);
  }

  FutureOr<void> redirect(
      CheckSessionEvent event, Emitter<AuthState> emit) async {
    try {
      final session = await serviceLocator.getSessionData();
      emit(AvailableSessionState(session));
    } catch (_) {
      emit(AvailableSessionState(null));
    }
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      try {
        await serviceLocator.signIn(
          userEmail: event.email,
          userPassword: event.password,
        );
        emit(LogInSuccessState());
      } on AuthException catch (error) {
        print(error);
        emit(LogInErrorState(error.message));
      } catch (error) {
        print(error);
        emit(LogInErrorState('Something went wrong'));
      }
    } else {
      emit(LogInErrorState('Invalid input'));
    }
  }

  FutureOr<void> signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    if (event.name.isNotEmpty &&
        event.email.isNotEmpty &&
        event.password.isNotEmpty) {
      try {
        await serviceLocator.signUp(
          userName: event.name,
          userEmail: event.email,
          userPassword: event.password,
        );
        emit(SignUpSuccessState());
      } on AuthException catch (error) {
        print(error);
        emit(SignUpErrorState(error.message));
      } catch (error) {
        print(error);
        emit(SignUpErrorState('Something went wrong'));
      }
    } else {
      emit(SignUpErrorState('Invalid input 2222'));
    }
  }

  FutureOr<void> logOut(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.signOut();
      emit(LogOutSuccessState());
    } catch (error) {
      print(error);
      emit(LogOutErrorState('Something went wrong'));
    }
  }
}
