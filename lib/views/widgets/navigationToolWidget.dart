import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ticket_application/map/map.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';
import 'package:ticket_application/views/widgets/showDialog.dart';
import 'dart:math' as math;

changeDirection(BuildContext context, StateSetter setStatee) async {
  if (ExpeditionSearchState.departure.name != "" &&
      ExpeditionSearchState.destination.name != "") {
    if (ExpeditionSearchState.departure.name !=
        ExpeditionSearchState.destination.name) {
      setStatee(() {
        var temp = ExpeditionSearchState.destination;
        ExpeditionSearchState.destination = ExpeditionSearchState.departure;
        ExpeditionSearchState.departure = temp;
      });
    } else {
      showDialogWidget(context, selectedLanguage.alertSameDirections);
    }
  } else if (ExpeditionSearchState.departure.name == "" &&
      ExpeditionSearchState.destination.name == "")
    showDialogWidget(context, selectedLanguage.alertChooseBoth);
  else if (ExpeditionSearchState.departure.name == "")
    showDialogWidget(context, selectedLanguage.alertChooseDeparture);
  else if (ExpeditionSearchState.destination.name == "")
    showDialogWidget(context, selectedLanguage.alertChooseDestination);
}

onListCity(BuildContext context, StateSetter setState, bool select, int i) {
  setState(() {
    if (select == true) {
      ExpeditionSearchState.departure = ExpeditionSearchState.locations[i];
      ExpeditionSearchState.selectedDeparture = true;
    } else {
      ExpeditionSearchState.destination = ExpeditionSearchState.locations[i];
      ExpeditionSearchState.selectedDestination = true;
    }
  });
  Navigator.pop(context);
}

Widget listCityContainer(
        BuildContext context, StateSetter setState, bool select) =>
    Container(
        padding: EdgeInsets.only(top: 49),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          for (int i = 0; i < ExpeditionSearchState.locations.length; i++)
            ListTile(
                title: new Text(ExpeditionSearchState.locations[i].name),
                onTap: () => onListCity(context, setState, select, i))
        ])));

bottomSheetCity(BuildContext context, StateSetter setState, bool select) =>
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        context: context,
        builder: (context) {
          return Stack(children: [
            Container(
              alignment: Alignment.center,
              height: 5,
              child: Container(
                  width: 60,
                  margin: EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16.0))),
            ),
            Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                alignment: Alignment.center,
                height: 35,
                //color: Colors.red,
                child: Text("Select City", style: TextStyle(fontSize: 16))),
            Container(
                height: 4,
                margin: EdgeInsets.only(top: 45),
                child: Divider(color: Colors.black)),
            listCityContainer(context, setState, select)
          ]);
        });
Widget navigationText(bool selectedBool, String selectedString, String choose) {
  if (selectedBool == true) {
    return Text(selectedString,
        style: TextStyle(color: Colors.black, fontSize: 16));
  } else {
    return Text(choose, style: TextStyle(color: Colors.grey, fontSize: 16));
  }
}

Widget navigationButtons(
    String title,
    String choose,
    String selectedString,
    bool selectedBool,
    BuildContext context,
    StateSetter setState,
    bool select) {
  return Container(
      padding: EdgeInsets.only(right: 8, left: 16),
      child: Column(children: [
        Container(
            width: 200,
            child: Text(title,
                //stextAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))),
        Container(
            width: 200,
            child: GestureDetector(
                onTap: () => bottomSheetCity(context, setState, select),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: Colors.black.withOpacity(0.5)))),
                    //alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 8, bottom: 16),
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          navigationText(selectedBool, selectedString, choose),
                          Icon(Icons.arrow_drop_down)
                        ]))))
      ]));
}

btnMaps(BuildContext context) {
  String alertText = "";
  if (ExpeditionSearchState.departure.name != "" &&
      ExpeditionSearchState.destination.name != "") {
    if (ExpeditionSearchState.departure.name ==
        ExpeditionSearchState.destination.name) {
      showDialogWidget(context, selectedLanguage.alertSameDirections);
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MapScreen()));
    }
  } else {
    if (ExpeditionSearchState.departure.name == "") {
      alertText = selectedLanguage.alertChooseDeparture;
    }
    if (ExpeditionSearchState.destination.name == "") {
      alertText = selectedLanguage.alertChooseDestination;
    }
    if (ExpeditionSearchState.departure.name == "" &&
        ExpeditionSearchState.destination.name == "") {
      alertText = selectedLanguage.alertChooseBoth;
    }
    showDialogWidget(context, alertText);
  }
}

Widget btnChangeDirectionContainer(
        BuildContext context, StateSetter setStatee) =>
    Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        width: 40,
        height: 45,
        child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(90 * math.pi / 180),
            child: IconButton(
                icon: Image(image: AssetImage('assets/exchange.png')),
                //wifi_protected_setup
                onPressed: () {
                  changeDirection(context, setStatee);
                })));

Widget mapText(BuildContext context) =>
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      RichText(
          text: TextSpan(
              text: selectedLanguage.routeMap,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
              children: [
            TextSpan(
                text: selectedLanguage.mapClick,
                style: TextStyle(
                    color: Colors.red[300], fontStyle: FontStyle.italic),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => btnMaps(context))
          ])),
      mapIconContainer(context)
    ]);

Widget mapIconContainer(BuildContext context) => Container(
    //color: Colors.red,
    width: 30,
    height: 30,
    alignment: Alignment.center,
    child: IconButton(
        padding: EdgeInsets.all(0),
        iconSize: 32,
        onPressed: () {
          btnMaps(context);
        },
        icon: Image(image: AssetImage('assets/route.png'))));

Widget locationIconsContainer() => Container(
        //margin: EdgeInsets.all(5),
        child: Column(children: [
      SizedBox(height: 10),
      Image(height: 24, width: 24, image: AssetImage('assets/driving.png')),
      Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
      Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
      Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Image(height: 24, width: 24, image: AssetImage('assets/destination.png')),
      //Icon(Icons.location_pin)
    ]));

Widget navigationButtonsContainer(
        BuildContext context, StateSetter setStatee) =>
    Container(
        padding: EdgeInsets.only(right: 8, left: 4),
        child: Column(children: [
          SizedBox(height: 8),
          navigationButtons(
              selectedLanguage.departure,
              selectedLanguage.chooseDeparture,
              ExpeditionSearchState.departure.name,
              ExpeditionSearchState.selectedDeparture,
              context,
              setStatee,
              true),
          navigationButtons(
              selectedLanguage.destination,
              selectedLanguage.chooseDestination,
              ExpeditionSearchState.destination.name,
              ExpeditionSearchState.selectedDestination,
              context,
              setStatee,
              false)
        ]));

Widget navigationTool(BuildContext context, StateSetter setStatee) {
  return Row(children: [
    locationIconsContainer(),
    navigationButtonsContainer(context, setStatee),
    btnChangeDirectionContainer(context, setStatee),
  ]);
}

Widget navigationToolContainer(BuildContext context, StateSetter setStatee) =>
    Container(
        padding: EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 20),
        margin: EdgeInsets.only(right: 32, left: 32, top: 8, bottom: 8),
        decoration: boxDecorationWidget(Colors.white),
        child: Column(
            children: [navigationTool(context, setStatee), mapText(context)]));
