class Message {
  String id;
  String profileId;
  String content;
  DateTime createdAt;
  bool isMine;

  Message(
    this.id,
    this.profileId,
    this.content,
    this.createdAt,
    this.isMine,
  );

  Message.fromJson({
    required Map<String, dynamic> json,
    required String myUserID,
  })  : id = json['id'],
        profileId = json['profile_id'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']),
        isMine = myUserID == json['profile_id'];
}
