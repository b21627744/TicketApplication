import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ticket_application/services/expeditionInitiale.dart';
import 'package:ticket_application/utils/expeditionDatabase.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:flutter/widgets.dart';

late ExpeditionDatabase expeditionDatabase;
bool databasecontrol = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await expeditionInitialize();

  runApp(MyApp());
}

/*FutureBuilder(BuildContext context, AsyncSnapshot snapshot)
{
future: getDocuments(),
builder: switch(snapshot.ConnectionState){
           case ConnectionState.waiting: return Text('Loading...)
           case ConnectionState.done: ...*/

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  static var language;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('tr')],
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFFFEB3B, color),
        /*cardTheme: CardTheme(
            //color: MaterialColor(0xFFFFEB3B, color),
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(40.0),
              ),
            )),*/
        canvasColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: ExpeditionSearch(),
    );
  }
}
