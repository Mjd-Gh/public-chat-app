import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/extension/app_extension.dart';
import 'package:public_chat_app/chat/model/message_model.dart';
import 'package:public_chat_app/auth/model/profile_model.dart';
import 'package:public_chat_app/auth/views/log_in_view.dart';
import 'package:public_chat_app/chat/bloc/chat_bloc.dart';
import 'package:public_chat_app/auth/bloc/auth_bloc.dart';
import 'package:public_chat_app/chat/widgets/chat_bubble.dart';
import 'package:public_chat_app/chat/widgets/message_bar.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final chatBloc = context.read<ChatBloc>();
    chatBloc.add(GetMessagesEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 54, 54),
        title: const Text(
          "Chat Room",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogOutSuccessState) {
              context.pushAndRemove(LoginView());
            }
            if (state is LogOutErrorState) {
              context.showErrorSnackBar(state.msg);
            }
          },
          child: IconButton(
            onPressed: () {
              authBloc.add(LogoutEvent());
              context.pushAndRemove(LoginView());
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      //==============================================================
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ShowMessageStreamState) {
            return StreamBuilder<List<Message>>(
              stream: state.messageList,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final messages = snapshot.data;
                  // != null
                  //     ? snapshot.data!
                  //     : []; // List of messages

                  return Column(
                    children: [
                      Expanded(
                        child: messages!.isEmpty
                            ? const Center(
                                child: Text("Start Chatting"),
                              )
                            : ListView.builder(
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  chatBloc.loadProfileCache(message.profileId);
                                  return ChatBubble(
                                    message: message,
                                    profile: chatBloc
                                            .profileCache[message.profileId] ??
                                        Profile('0', 'test', DateTime.now()),
                                  );
                                },
                              ),
                      ),
                      MessageBar(),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text("Sorry Nothing to display"),
                );
              },
            );
          }
          return const Center(
            child: Text("Sorry Nothing to display"),
          );
        },
      ),
    );
  }
}
