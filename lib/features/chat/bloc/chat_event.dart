part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetMessagesEvent extends ChatEvent {}

// Submit message Event
// ignore: must_be_immutable
class SubmitMessageEvent extends ChatEvent {
  String message;
  SubmitMessageEvent(this.message);
}
