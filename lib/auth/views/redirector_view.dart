import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/extension/app_extension.dart';
import 'package:public_chat_app/auth/views/log_in_view.dart';
import 'package:public_chat_app/auth/bloc/auth_bloc.dart';
import 'package:public_chat_app/chat/view/chat_view.dart';

class RedirectView extends StatelessWidget {
  const RedirectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AvailableSessionState) {
          if (state.isSessionAvailable != null) {
            context.pushAndRemove( const ChatView());
          } else {
            context.pushAndRemove(LoginView());
          }
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text("This is a Redirect view"),
        ),
      ),
    );
  }
}
