// To parse this JSON data, do
//
//     final componentModel = componentModelFromJson(jsonString);

import 'dart:convert';

ComponentModel componentModelFromJson(String str) =>
    ComponentModel.fromJson(json.decode(str));

String componentModelToJson(ComponentModel data) => json.encode(data.toJson());

class ComponentModel {
  String? description;
  String? id;
  String? imageUrl;
  bool? isActive;
  String? link;
  String? name;

  ComponentModel({
    this.description,
    this.id,
    this.imageUrl,
    this.isActive,
    this.link,
    this.name,
  });

  ComponentModel copyWith({
    String? description,
    String? id,
    String? imageUrl,
    bool? isActive,
    String? link,
    String? name,
  }) =>
      ComponentModel(
        description: description ?? this.description,
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        isActive: isActive ?? this.isActive,
        link: link ?? this.link,
        name: name ?? this.name,
      );

  factory ComponentModel.fromJson(Map<String, dynamic> json) => ComponentModel(
        description: json["description"],
        id: json["id"] == null ? null : Id.fromJson(json["id"]).id,
        imageUrl: json["image_url"],
        isActive: json["is_active"],
        link: json["link"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "image_url": imageUrl,
        "is_active": isActive,
        "link": link,
        "name": name,
      };
}

class Id {
  String? id;

  Id({
    this.id,
  });

  Id copyWith({
    String? id,
  }) =>
      Id(
        id: id ?? this.id,
      );

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
