import 'package:flutter/material.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/widgets/expeditionWidget.dart';

class ListAllExpenditions extends StatefulWidget {
  ListAllExpenditions({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ListAllExpenditionsState createState() => ListAllExpenditionsState();
}

class ListAllExpenditionsState extends State<ListAllExpenditions> {
  List<ExpeditionCard> allExpeditions = [];
  List<ExpeditionCard> searchExpeditions() {
    allExpeditions = [];
    ExpeditionSearch.expeditionList.forEach((element) {
      allExpeditions.add(ExpeditionCard(cardModel: element));
    });
    print(allExpeditions.length);
    return allExpeditions;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("List All Expeditions"),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: searchExpeditions().toList(),
        ),
      ),
    );
  }
}
