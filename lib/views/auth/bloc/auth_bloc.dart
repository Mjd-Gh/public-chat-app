// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:public_chat_app/models/profile_model.dart';
import 'package:public_chat_app/services/database_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final serviceLocator = GetIt.I.get<DBService>();
  Map<String, Profile> profileCache = {};

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
    final session = await serviceLocator.getSessionData();
    emit(AvailableSessionState(session));
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.signIn(
        userEmail: event.email,
        userPassword: event.password,
      );
      emit(SuccessState());
    } on AuthException catch (error) {
      print(error);
      emit(ErrorState('Invalid input'));
    } catch (error) {
      print(error);
      emit(ErrorState('Something went wrong'));
    }
  }

  FutureOr<void> signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.signUp(
        userName: event.name,
        userEmail: event.email,
        userPassword: event.password,
      );
      emit(SuccessState());
    } on AuthException catch (error) {
      print(error);
      emit(ErrorState('Invalid input'));
    } catch (error) {
      print(error);
      emit(ErrorState('Something went wrong'));
    }
  }

  FutureOr<void> logOut(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.signOut();
      emit(SuccessState());
    } catch (error) {
      print(error);
      emit(ErrorState('Something went wrong'));
    }
  }
}
