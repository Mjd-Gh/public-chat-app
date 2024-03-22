import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/services/data_localization.dart';
import 'package:public_chat_app/services/database_connector.dart';
import 'package:public_chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:public_chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:public_chat_app/features/auth/views/redirector_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  DataLocalization().setupDataLocalization();
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
