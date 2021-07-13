import 'package:flutter/material.dart';

abstract class Languages {

  Locale get locale;

  String get ticketApp;
  String get departure;
  String get chooseDeparture;
  String get destination;
  String get chooseDestination;
  String get expeditionDate;
  String get routeMap;
  String get mapClick;
  String get searchButton;
  String get allExpeditions;


  String get alertSameDirections;
  String get alertChooseDeparture;
  String get alertChooseDestination;
  String get alertChooseBoth;
  String get expeditionTitle;
  String get noExpeditionFound;
  String get expeditionFound;

  String get listAllTitle;
  String get departureTime;

  String get choosingSeatTitle;
  String get passanger;
  String get seatNumber;
  String get totalPrice;
  String get sold;
  String get female;
  String get male;
  String get empty;
  String get scroll;
  String get continueButton;
  String get alertChoose;
  String get alertSold;
  String get selectGender;
/*
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Languages && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;*/
}
