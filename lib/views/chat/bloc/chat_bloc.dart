// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:public_chat_app/models/message_model.dart';
import 'package:public_chat_app/models/profile_model.dart';
import 'package:public_chat_app/services/database_services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final serviceLocator = GetIt.I.get<DBService>();
  Map<String, Profile> profileCache = {};

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});

    //--- Get All Messages ----
    on<GetMessagesEvent>(getMessages);

    // -- Submit/Send a Message ---
    on<SubmitMessageEvent>(submitMessage);
  }

  FutureOr<void> submitMessage(event, emit) async {
    try {
      await serviceLocator.submitMessage(event.message);
      emit(SendMessageState());
      await serviceLocator.getMessagesStream();
      Stream<List<Message>> messages = serviceLocator.listOfMessages;
      emit(ShowMessageStreamState(messages));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  FutureOr<void> getMessages(event, emit) async {
    await serviceLocator.getMessagesStream();
    Stream<List<Message>> messages = serviceLocator.listOfMessages;
    emit(ShowMessageStreamState(messages));
  }

  //------ Loading Profile message Data ---
  Future<void> loadProfileCache(String profileId) async {
    if (profileCache[profileId] != null) {
      return;
    }
    final profileData = await serviceLocator.getProfileData(profileId);
    profileCache[profileId] = profileData;
    await serviceLocator.getMessagesStream();
    Stream<List<Message>> messages = serviceLocator.listOfMessages;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(ShowMessageStreamState(messages));
  }
}
