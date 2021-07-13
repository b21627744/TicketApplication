import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';
import 'package:ticket_application/views/widgets/btnSearch.dart';
import 'package:ticket_application/views/widgets/expeditionDate.dart';
import 'package:ticket_application/views/widgets/navigationToolWidget.dart';
import 'expeditionSearch.dart';

class ExpeditionSearchResult extends StatefulWidget {
  ExpeditionSearchResult({Key? key}) : super(key: key);

  @override
  ExpeditionSearchResultState createState() => ExpeditionSearchResultState();
}

class ExpeditionSearchResultState extends State<ExpeditionSearchResult> {
  Widget listExpeditions() {
    if (ExpeditionSearch.searchedExpeditions.length != 0) {
      return Column(children: [
        Text(ExpeditionSearch.searchedExpeditions.length.toString() +
            selectedLanguage.expeditionFound),
        Column(children: ExpeditionSearch.searchedExpeditions.toList())
      ]);
    }
    return Center(child: Text(selectedLanguage.noExpeditionFound));
  }

  bottomSheetSearch(BuildContext context, StateSetter setState) =>
      showModalBottomSheet(
          context: context,
          elevation: 0,
          barrierColor: Colors.black.withAlpha(1),
          //backgroundColor: Colors.grey.withOpacity(0.2),
          //backgroundColor: Colors.white,
          builder: (context) {
            return Container(
              decoration: new BoxDecoration(
                //color: Colors.grey,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0)),
              ),
              child: StatefulBuilder(builder:
                  (BuildContext context, StateSetter bottomSheetsetState) {
                return SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  navigationToolContainer(context, bottomSheetsetState),
                  expeditionDateToolContainer(context, bottomSheetsetState),
                  btnSearchContainer(context, setState, false),
                ]));
              }),
            );
          });

  Widget expeditionsInfoContainer(BuildContext context, StateSetter setState) {
    return GestureDetector(
        onTap: () => bottomSheetSearch(context, setState),
        child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 32, bottom: 32, right: 40, left: 40),
            decoration: boxDecorationWidget(Colors.white),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(ExpeditionSearchState.departure.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                Icon(Icons.arrow_right_sharp, color: Colors.black, size: 48),
                Text(ExpeditionSearchState.destination.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(Jiffy(ExpeditionSearchState.currentDate).yMMMMd,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black))
              ]),
              SizedBox(height: 10)
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 45, title: Text(selectedLanguage.expeditionTitle)),
        body: Container(
            child: Column(children: [
          expeditionsInfoContainer(context, setState),
          listExpeditions()
        ])));
  }
}
