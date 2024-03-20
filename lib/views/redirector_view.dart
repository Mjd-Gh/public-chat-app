// import 'package:flutter/material.dart';
// import 'package:public_chat_app/views/auth/bloc/auth_bloc.dart';

// class RedirectView extends StatelessWidget {
//   const RedirectView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AvailableSessionState) {
//           if (state.isSessionAvailable != null) {
//             // context.pushAndRemove( const ChatView());
//           } else {
//             // context.pushAndRemove(LoginView());
//           }
//         }
//       },
//       child: const Scaffold(
//         body: Center(
//           child: Text("This is a Redirect view"),
//         ),
//       ),
//     );
//   }
// }
