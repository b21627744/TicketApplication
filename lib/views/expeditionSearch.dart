import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ticket_application/languages/language_en.dart';
import 'package:ticket_application/languages/language_tr.dart';
import 'package:ticket_application/languages/languages.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/models/locations.dart';
import 'package:ticket_application/views/listAllExpeditions.dart';
import 'package:ticket_application/views/widgets/btnSearch.dart';
import 'package:ticket_application/views/widgets/expeditionDate.dart';
import 'package:ticket_application/views/widgets/expeditionWidget.dart';
import 'package:ticket_application/views/widgets/navigationToolWidget.dart';

import '../main.dart';

List<Languages> languages = [
  LanguageTr(),
  LanguageEn(),
];
Languages selectedLanguage = setLanguage(languages[1]); // LanguageEn();

Languages setLanguage(Languages l) {
  Jiffy.locale(l.locale.countryCode);
  return l;
}

class ExpeditionSearch extends StatefulWidget {
  static List<Expedition> expeditionList = [];
  static List<ExpeditionCard> searchedExpeditions = [];
  static late int ticketId;

  ExpeditionSearch({Key? key}) : super(key: key);

  @override
  ExpeditionSearchState createState() => ExpeditionSearchState();
}

class ExpeditionSearchState extends State<ExpeditionSearch> {
  static DateTime currentDateFinal = DateTime.now();
  static DateTime currentDate = DateTime.now();

  static List<Location> locations = [];
  static String selectedLocationDeparture = "";
  static String selectedLocationDestination = "";
  static Location departure =
      Location(id: 100, name: "", latitude: 0, longitude: 0);
  static Location destination =
      Location(id: 101, name: "", latitude: 0, longitude: 0);
  static bool selectedDeparture = false;
  static bool selectedDestination = false;

  @override
  initState() {
    super.initState();

    insertExpeditions();
  }

  Future<void> insertExpeditions() async {
    final db1 = await expeditionDatabase.db;

    final List<Map<String, dynamic>> ticketmaps =
        await db1.query('ticket_table3');
    ExpeditionSearch.ticketId = ticketmaps.length;

    final List<Map<String, dynamic>> maps =
        await db1.query('expeditions_table2');
    ExpeditionSearch.expeditionList = [];
    ExpeditionSearch.expeditionList = List.generate(maps.length, (i) {
      return Expedition(
        id: maps[i]['id'],
        name: maps[i]['name'],
        date: maps[i]['date'],
        hour: maps[i]['hour'],
        departure: maps[i]['departure'],
        destination: maps[i]['destination'],
        seatsNumber: maps[i]['seatsNumber'],
        seatsList: maps[i]['seatsList'],
        seatsStyle: maps[i]['seatsStyle'],
        price: maps[i]['price'],
      );
    });
    await loadLocations();
  }

  loadLocations() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/cities.json");
    final jsonResult = json.decode(data);
    for (int i = 0; i < 81; i++) {
      locations.add(new Location(
          id: jsonResult[i]['id'],
          name: jsonResult[i]['name'],
          latitude: double.parse(jsonResult[i]['latitude']),
          longitude: double.parse(jsonResult[i]['longitude'])));
    }
  }

  onListAllExpeditions() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new ListAllExpenditions()));
  }

  void onChangedLanguage(Languages? newValue) {
    setState(() {
      selectedLanguage = setLanguage(newValue ?? LanguageEn());
      //selectedLanguage = newValue ?? LanguageEn();
    });
  }

  Widget btnListAllExpeditions(BuildContext context) => ElevatedButton(
        onPressed: onListAllExpeditions,
        child: Text(
          selectedLanguage.allExpeditions,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      );

  Widget btnListAllExpeditionsContainer(var height, var width) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: height / 8),
        child: btnListAllExpeditions(context),
      ),
    );
  }

  Widget btnLanguage(BuildContext context) => DropdownButton<Languages>(
        onChanged: onChangedLanguage,
        value: selectedLanguage,
        items: languages
            .map((l) => DropdownMenuItem<Languages>(
                child: Text(l.locale.countryCode ?? ''), value: l))
            .toList(),
        dropdownColor: Colors.white,
        hint: Icon(Icons.language_outlined),
      );

  Widget bodyContainer(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          navigationToolContainer(context, setState),
          expeditionDateToolContainer(context, setState),
          btnSearchContainer(context, setState, true),
          SizedBox(height: 64),
          btnListAllExpeditionsContainer(MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(selectedLanguage.ticketApp), btnLanguage(context)],
          ),
        ),
        body: databasecontrol == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(child: bodyContainer(context)));
  }
}
