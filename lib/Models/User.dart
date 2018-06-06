class User {
  String username;

  User({this.username});

  factory User.fromJson(Map<String, dynamic> json){
    return new User(
      username: json['username']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'Username': username,
      };
}