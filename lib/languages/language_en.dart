import 'package:flutter/material.dart';
import 'package:ticket_application/languages/languages.dart';

class LanguageEn extends Languages {
  Locale get locale => Locale("en", "EN");

  @override
  String get ticketApp => "Ticket Applicationnn";

  @override
  String get departure => "Departure";

  @override
  String get chooseDeparture => "Choose a departure";

  @override
  String get destination => "Destination";

  @override
  String get chooseDestination => "Choose a destination";

  @override
  String get expeditionDate => "Expedition Date";
  @override
  String get routeMap=>"To see the route on maps, ";
  @override
  String get mapClick=>"Click here.";

  @override
  String get searchButton => "Search";

  @override
  String get allExpeditions => "All Expeditions";

  @override
  String get alertSameDirections =>
      "Please choose different destination and departure";

  @override
  String get alertChooseDeparture => "Please choose departure";

  @override
  String get alertChooseDestination => "Please choose destination";

  @override
  String get alertChooseBoth => "Please choose departure and destination";

  @override
  String get expeditionTitle => "Expeditions";

  @override
  String get noExpeditionFound =>
      "No expedition were found matching your search criteria.";

  @override
  String get expeditionFound => "search results found";

  @override
  String get listAllTitle => "List All Expeditions";

  @override
  String get departureTime => "Departure Time";

  @override
  String get choosingSeatTitle => "Choosing Seat";

  @override
  String get passanger => "passenger";

  @override
  @override
  String get seatNumber => "Departure Time";

  @override
  String get totalPrice => "Departure Time";

  @override
  String get sold => "Sold";

  @override
  String get female => 'Female';

  @override
  String get male => 'Male';

  @override
  String get empty => "Empty";

  @override
  String get scroll => "scroll";

  @override
  String get continueButton => "Continue";

  @override
  String get alertChoose => "Please choose seat(s)";

  @override
  String get alertSold =>
      "This seat has already been sold. Please select an empty seat.";

  @override
  String get selectGender => "Please select gender";
}
