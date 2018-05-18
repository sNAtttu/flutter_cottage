class Config {
  final String devUrl;
  Config({this.devUrl});

  factory Config.fromJson(Map<String, dynamic> json){
    return new Config(
        devUrl: json['devUrl'],
    );
  }

}