class Profile {
  String id;
  String username;
  DateTime createdAt;

  Profile(this.id, this.username, this.createdAt);

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        createdAt = DateTime.parse(json['created_at']);
}
