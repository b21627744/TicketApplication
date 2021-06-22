import 'package:flutter/material.dart';
import 'package:ticket_application/views/expeditionSearch.dart';

import 'models/expedition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //print(HomePage.expeditionList.length);

    return MaterialApp(
      title: 'Ticket Application',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: ExpeditionSearch(title: 'Ticket Application'),
    );
  }
}
