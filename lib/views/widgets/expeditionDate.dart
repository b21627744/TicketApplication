import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';

Widget expeditionDateToolContainer(
        BuildContext context, StateSetter setStatee) =>
    Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      margin: EdgeInsets.only(right: 32, left: 32, top: 8, bottom: 16),
      decoration: boxDecorationWidget(Colors.white),
      child: expeditionDateTool(context, setStatee),
    );

Widget expeditionDateTool(BuildContext context, StateSetter setStatee) {
  return Stack(children: [
    Container(
        padding: EdgeInsets.only(left: 32, top: 20),
        alignment: Alignment.centerLeft,
        child: Icon(Icons.date_range, size: 32)),
    Column(children: [
      Center(
          child: Text(selectedLanguage.expeditionDate,
              style: TextStyle(fontWeight: FontWeight.bold))),
      SizedBox(height: 5),
      Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.0)),
          child: ElevatedButton(
              onPressed: () => _selectDate(context, setStatee),
              child: Text(Jiffy(ExpeditionSearchState.currentDate).yMMMMd,
                  style: TextStyle(color: Colors.black, fontSize: 20))))
    ])
  ]);
}

Future<void> _selectDate(BuildContext context, StateSetter setStatee) async {
  final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: selectedLanguage.locale,
      initialDate: ExpeditionSearchState.currentDate,
      firstDate: ExpeditionSearchState.currentDateFinal,
      lastDate: DateTime(2050));
  if (pickedDate != null && pickedDate != ExpeditionSearchState.currentDate)
    setStatee(() {
      ExpeditionSearchState.currentDate = pickedDate;
    });
}
