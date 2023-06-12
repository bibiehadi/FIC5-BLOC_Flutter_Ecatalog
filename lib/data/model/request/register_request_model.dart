// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromMap(jsonString);

import 'dart:convert';

class RegisterRequestModel {
  String? name;
  String? email;
  String? password;
  String? avatar;

  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.avatar = "https://api.lorem.space/image/face?w=640&h=480",
  });

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "avatar": avatar,
      };
}
