import 'package:flutter/foundation.dart';

class Expedition {
  String name;
  int id;
  DateTime date;
  String hour;
  String departure;
  String destination;
  int seatsNumber;
  String seatsStyle;
  double price;

  Expedition({
    @required this.name,
    @required this.id,
    @required this.date,
    @required this.hour,
    @required this.departure,
    @required this.destination,
    @required this.seatsNumber,
    @required this.seatsStyle,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'date': date,
      'hour': hour,
      'departure': departure,
      'destination': destination,
      'seatsNumber': seatsNumber,
      'seatsStyle': seatsStyle,
      'price': price,
    };
  }

  factory Expedition.fromMap(Map<String, dynamic> map) {
    if (map == null) throw ArgumentError("Source can not be null");
    return Expedition(
      name: map['name'] ?? "",
      id: map['id'] ?? "",
      date: map['date'] ?? "",
      hour: map['hour'] ?? "",
      departure: map['departure'] ?? "",
      destination: map['destination'] ?? "",
      seatsNumber: map['seatsNumber'] ?? "",
      seatsStyle: map['seatsStyle'] ?? "",
      price: map['price'] ?? "",
    );
  }
}
