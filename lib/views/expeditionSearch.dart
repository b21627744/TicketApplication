import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/views/expeditionSearchResult.dart';
import 'package:ticket_application/views/listAllExpeditions.dart';
import 'package:ticket_application/views/widgets/expeditionWidget.dart';

class ExpeditionSearch extends StatefulWidget {
  ExpeditionSearch({Key key, this.title}) : super(key: key);
  final String title;
  static List<Expedition> expeditionList = [];
  static List<ExpeditionCard> searchedExpeditions = [];

  @override
  ExpeditionSearchState createState() => ExpeditionSearchState();
}

class ExpeditionSearchState extends State<ExpeditionSearch> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  bool searchResult = false;
  List<String> _locations = [
    '01 Adana',
    '02 Adıyaman',
    '03 Afyon',
    '04 Ağrı',
    '05 Amasya',
    '06 Ankara',
    '07 Antalya',
    '08 Artvin',
    '09 Aydın',
    '10 Balıkesir',
    '11 Bilecik',
    '12 Bingöl',
    '13 Bitlis',
    '14 Bolu',
    '15 Burdur',
    '16 Bursa',
    '17 Çanakkale',
    '18 Çankırı',
    '19 Çorum',
    '20 Denizli',
    '21 Diyarbakır',
    '22 Edirne',
    '23 Elazığ',
    '24 Erzincan',
    '25 Erzurum',
    '26 Eskişehir',
    '27 Gaziantep',
    '28 Giresun',
    '29 Gümüşhane',
    '30 Hakkari',
    '31 Hatay',
    '32 Isparta',
    '33 İçel (Mersin)',
    '34 İstanbul',
    '35 İzmir',
    '36 Kars',
    '37 Kastamonu',
    '38 Kayseri',
    '39 Kırklareli',
    '40 Kırşehir',
    '41 Kocaeli',
    '42 Konya',
    '43 Kütahya',
    '44 Malatya',
    '45 Manisa',
    '46 K.maraş',
    '47 Mardin',
    '48 Muğla',
    '49 Muş',
    '50 Nevşehir',
    '51 Niğde',
    '52 Ordu',
    '53 Rize',
    '54 Sakarya',
    '55 Samsun',
    '56 Siirt',
    '57 Sinop',
    '58 Sivas',
    '59 Tekirdağ',
    '60 Tokat',
    '61 Trabzon',
    '62 Tunceli',
    '63 Şanlıurfa',
    '64 Uşak',
    '65 Van',
    '66 Yozgat',
    '67 Zonguldak',
    '68 Aksaray',
    '69 Bayburt',
    '70 Karaman',
    '71 Kırıkkale',
    '72 Batman',
    '73 Şırnak',
    '74 Bartın',
    '75 Ardahan',
    '76 Iğdır',
    '77 Yalova',
    '78 Karabük',
    '79 Kilis',
    '80 Osmaniye',
    '81 Düzce',
  ]; // Option 2
  String _selectedLocationDeparture;
  String _selectedLocationDestination;

  DateTime currentDatefinal = DateTime.now();
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDatefinal,
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  Future<void> changeDirection(BuildContext context) async {
    if (_selectedLocationDeparture != null &&
        _selectedLocationDestination != null) {
      setState(() {
        var temp = _selectedLocationDestination;
        _selectedLocationDestination = _selectedLocationDeparture;
        _selectedLocationDeparture = temp;
      });
    }
  }

  Future<void> searchExpedition(
      String departure, String destination, DateTime date) async {
    setState(() {
      ExpeditionSearch.searchedExpeditions = [];
    });

    ExpeditionSearch.expeditionList.forEach((element) {
      if (element.departure == departure &&
          element.destination == destination &&
          element.date.toString().substring(0, 10) ==
              date.toString().substring(0, 10)) {
        setState(() {
          ExpeditionSearch.searchedExpeditions
              .add(ExpeditionCard(cardModel: element));
        });
      }
    });
  }

  Future<void> insertExpeditions() async {
    ExpeditionSearch.expeditionList = [];
    var map;
    var expeditionModel;
    int i = 0;

    map = {
      'name': "Kamil Koç",
      'id': i,
      'date': DateTime.utc(2021, 6, 23),
      'hour': "10:00",
      'departure': "01 Adana",
      'destination': "33 İçel (Mersin)",
      'seatsNumber': 43,
      'seatsStyle': "2+1",
      'price': 60.0,
    };

    expeditionModel = Expedition.fromMap(map);
    ExpeditionSearch.expeditionList.add(expeditionModel);
    i++;
    map = {
      'name': "Metro",
      'id': i,
      'date': DateTime.utc(2021, 8, 10),
      'hour': "10:00",
      'departure': "11 Bilecik",
      'destination': "06 Ankara",
      'seatsNumber': 43,
      'seatsStyle': "2+2",
      'price': 50.0,
    };
    expeditionModel = Expedition.fromMap(map);
    ExpeditionSearch.expeditionList.add(expeditionModel);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    insertExpeditions();
    return Scaffold(
        appBar: AppBar(
          title: Text("Expedition Search"),
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    //border: Border.all(color: Colors.blueAccent),
                  ),
                  //color: Colors.black,
                  height: height / 5,
                  width: width / 1.2,
                  padding: EdgeInsets.only(
                    left: width / 35,
                    top: height / 40,
                  ),
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        //margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Icon(Icons.location_pin),
                            Text(
                              ":",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ":",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Icon(Icons.location_pin),
                          ],
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Column(
                          children: [
                            //SizedBox(height: 30),
                            Container(
                              width: 200,
                              child: Text(
                                "Departure",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DropdownButton(
                              hint: Text(
                                  'Choose a departure       '), // Not necessary for Option 1
                              value: _selectedLocationDeparture,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocationDeparture = newValue;
                                });
                              },
                              items: _locations.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                "Destination",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DropdownButton(
                              hint: Text(
                                  'Choose a destination     '), // Not necessary for Option 1
                              value: _selectedLocationDestination,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocationDestination = newValue;
                                });
                              },
                              items: _locations.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        width: 40,
                        height: 40,
                        child: IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.wifi_protected_setup),
                          tooltip: '',
                          onPressed: () {
                            setState(() {
                              changeDirection(context);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height / 6.5,
                width: width / 1.2,
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 15),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  //border: Border.all(color: Colors.blueAccent),
                ),
                child: Row(children: [
                  Icon(Icons.date_range),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          "Expedition Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      //style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 10),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text(Jiffy(currentDate).yMMMMd,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          /*style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          side: BorderSide(color: Colors.red)))),*/
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  searchExpedition(_selectedLocationDeparture,
                      _selectedLocationDestination, currentDate);
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ExpeditionSearchResult()));
                },
                child: Container(
                  width: 300,
                  height: 40,
                  child: Center(
                    child: Text('Search Expedition',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                ),
                /* style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(color: Colors.red)))),*/
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      //padding: EdgeInsets.all(15.0),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ListAllExpenditions()));
                      },
                      child: Text(
                        "List All Expeditions",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
