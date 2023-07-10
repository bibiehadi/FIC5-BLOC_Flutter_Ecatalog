// To parse this JSON data, do
//
//     final updateRequestModel = updateRequestModelFromJson(jsonString);

import 'dart:convert';

class UpdateRequestModel {
  String? title;
  int? price;
  String? description;

  UpdateRequestModel({
    this.title,
    this.price,
    this.description,
  });

  factory UpdateRequestModel.fromRawJson(String str) =>
      UpdateRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateRequestModel(
        title: json["title"],
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "description": description,
      };
}
