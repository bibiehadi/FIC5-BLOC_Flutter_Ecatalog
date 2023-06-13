// To parse this JSON data, do
//
//     final addProductRequestModel = addProductRequestModelFromMap(jsonString);

import 'dart:convert';

class AddProductRequestModel {
  String title;
  int price;
  String description;
  int categoryId;
  List<String> images;

  AddProductRequestModel({
    required this.title,
    required this.price,
    required this.description,
    this.categoryId = 1,
    this.images = const [
      'https://placeimg.com/640/480/any',
    ],
  });

  factory AddProductRequestModel.fromJson(String str) =>
      AddProductRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductRequestModel.fromMap(Map<String, dynamic> json) =>
      AddProductRequestModel(
        title: json["title"],
        price: json["price"],
        description: json["description"],
        categoryId: json["categoryId"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "price": price,
        "description": description,
        "categoryId": categoryId,
        "images":
            images == null ? [] : List<dynamic>.from(images.map((x) => x)),
      };
}
