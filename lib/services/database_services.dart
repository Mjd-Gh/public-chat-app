import 'package:public_chat_app/models/message_model.dart';
import 'package:public_chat_app/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  // Supabase Client
  final SupabaseClient supabase = Supabase.instance.client;
  late Stream<List<Message>> listOfMessages; // Fetched Messages

  //-------------------- Auth Operations -------------------------
  // 1. Sign up Function
  Future signUp({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    await supabase.auth.signUp(
      data: {'username': userName},
      email: userEmail,
      password: userPassword,
    );
  }

  // 2. Sign in Function
  Future signIn({
    required String userEmail,
    required String userPassword,
  }) async {
    await supabase.auth.signInWithPassword(
      email: userEmail,
      password: userPassword,
    );
  }

  // 3. Sign Out
  Future signOut() async {
    await supabase.auth.signOut();
  }

  //------------------------------------------------------------
  // ---------  Fetching user and session info Operations ------

  //-- Getting session data for routing --
  Future getSessionData() async {
    /**
     This line pauses the execution of the function for a very 
     short amount of time (zero seconds) before continuing.
     it ensures that the widget tree is fully built before 
     attempting to access the current user session.
    */
    // await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;
    print("-------------------------------");
    print("Session Data $session");
    print("-------------------------------");
    return session;
  }

  // -- Getting current user ID --
  Future getCurrentUserID() async {
    final currentUserId = supabase.auth.currentUser?.id;
    return currentUserId;
  }

  // -- Get messages stream --
  Future getMessagesStream() async {
    final userID = await getCurrentUserID();
    final msgStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromJson(json: map, myUserID: userID))
            .toList());
    listOfMessages = msgStream;
  }


  // --- Get Profile data by profile ID of a specific message ---
  Future getProfileData(String profileID) async {
    final data =
        await supabase.from('profiles').select().eq('id', profileID).single();
    final profile = Profile.fromJson(data);
    return profile;
  }

  // -- Submit message --
  Future submitMessage(String msgContent) async {
    final currentUserId = await getCurrentUserID();
    await supabase.from("messages").insert({
      'profile_id': currentUserId,
      'content': msgContent,
    });
  }
}
