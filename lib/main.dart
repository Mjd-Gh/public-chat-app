import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/injections/data_injection.dart';
import 'package:public_chat_app/services/database_connector.dart';
import 'package:public_chat_app/views/auth/bloc/auth_bloc.dart';
import 'package:public_chat_app/views/redirector_view.dart';

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
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckSessionEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RedirectView(),
      ),
    );
  }
}
