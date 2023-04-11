class LoginModel {
  User? user;
  String? token;

  LoginModel.fromJson(Map<String,dynamic> json){
    user = User.fromJson(json['user']);
    token = json["token"];
  }
}

class User {
  late int id;
  late String name;
  late String email;
  
  User.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
}
