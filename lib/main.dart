import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/injections/data_injection.dart';
import 'package:public_chat_app/services/database_connector.dart';
import 'package:public_chat_app/auth/bloc/auth_bloc.dart';
import 'package:public_chat_app/chat/bloc/chat_bloc.dart';
import 'package:public_chat_app/auth/views/redirector_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  DataInjection().setupDataInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckSessionEvent()),
        ),
        BlocProvider(
          create: (context) => ChatBloc()..add(GetMessagesEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RedirectView(),
      ),
    );
  }
}
