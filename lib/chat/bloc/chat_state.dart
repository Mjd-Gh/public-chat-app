part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

// ---- ResultStates ----
class SuccessState extends ChatState{}
// ignore: must_be_immutable
class ErrorState extends ChatState{
  String msg;
  ErrorState(this.msg);
}

// ---- Show Messages State ---
// ignore: must_be_immutable
class ShowMessageStreamState extends ChatState {
  Stream<List<Message>> messageList;
  ShowMessageStreamState(
    this.messageList,
  );
}

// ---- Sending message state -----
class SendMessageState extends ChatState {}