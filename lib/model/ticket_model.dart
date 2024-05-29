// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

TicketModel ticketModelFromJson(String str) =>
    TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  String? description;
  String? eventId;
  String? id;
  String? name;
  String? url;

  TicketModel({
    this.description,
    this.eventId,
    this.id,
    this.name,
    this.url,
  });

  TicketModel copyWith({
    String? description,
    String? eventId,
    String? id,
    String? name,
    String? url,
  }) =>
      TicketModel(
        description: description ?? this.description,
        eventId: eventId ?? this.eventId,
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        description: json["description"],
        eventId: json["event_id"],
        id: json["id"] == null ? null : Id.fromJson(json["id"]).id,
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "event_id": eventId,
        "id": id,
        "name": name,
        "url": url,
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
