import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/features/chat/bloc/chat_bloc.dart';

// ignore: must_be_immutable
class MessageBar extends StatelessWidget {
   MessageBar({
    super.key,
  });

  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();//-----------
    return Container(
      color: const Color.fromARGB(255, 54, 54, 54),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: msgController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                bloc.add(SubmitMessageEvent(msgController.text));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 249, 156),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
