import 'package:flutter/material.dart';
import 'package:public_chat_app/constants/spacing.dart';
import 'package:public_chat_app/models/message_model.dart';
import 'package:public_chat_app/models/profile_model.dart';
import 'package:timeago/timeago.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.profile});

  final Message message;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
   List<Widget> chatContents = [
      // Show a Circular avatar for other senders
      if (!message.isMine)
        CircleAvatar(
          backgroundColor: Colors.red[200],
          child: Text(
            profile.username.substring(0, 2),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      kH8,
      kH4,
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? Color.fromARGB(255, 79, 158, 143)
                : Color.fromARGB(255, 223, 223, 223),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft: message.isMine
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              bottomRight: message.isMine
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
              topRight: const Radius.circular(15),
            ),
          ),
          child: Text(
            message.content,
            style: TextStyle(
              color: message.isMine ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      kH8,
      kH4,
      Text(format(message.createdAt, locale: 'en_short')),
      kV64,
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
