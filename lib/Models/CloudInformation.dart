class CloudInformation {
  final int all;

  CloudInformation({this.all});

  factory CloudInformation.fromJson(Map<String, dynamic> json){
    return new CloudInformation(
        all: json['all']
    );
  }

}