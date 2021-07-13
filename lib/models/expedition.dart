import 'package:flutter/foundation.dart';

class Expedition {
  int id;
  String name;
  String date;
  String hour;
  String departure;
  String destination;
  int seatsNumber;
  String seatsList;
  String seatsStyle;
  int price;

  Expedition({
    required this.id,
    required this.name,
    required this.date,
    required this.hour,
    required this.departure,
    required this.destination,
    required this.seatsNumber,
    required this.seatsList,
    required this.seatsStyle,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'hour': hour,
      'departure': departure,
      'destination': destination,
      'seatsNumber': seatsNumber,
      'seatsList': seatsList,
      'seatsStyle': seatsStyle,
      'price': price,
    };
  }

  factory Expedition.fromMap(Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison
    if (map == null) throw ArgumentError("Source can not be null");
    return Expedition(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      date: map['date'] ?? "",
      hour: map['hour'] ?? "",
      departure: map['departure'] ?? "",
      destination: map['destination'] ?? "",
      seatsNumber: map['seatsNumber'] ?? "",
      seatsList: map['seatsList'] ?? "",
      seatsStyle: map['seatsStyle'] ?? "",
      price: map['price'] ?? "",
    );
  }
  @override
  String toString() {
    return 'Expedition{id: $id, name: $name,date: $date,departure: $departure,destination: $destination}';
  }
}
