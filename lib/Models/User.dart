class User {
  String username;

  User({this.username});

  Map<String, dynamic> toJson() =>
      {
        'Username': username,
      };
}