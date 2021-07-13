import 'package:ticket_application/main.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/utils/expeditionDatabase.dart';

Future<void> expeditionInitialize() async {
  expeditionDatabase = ExpeditionDatabase();
  final db1 = await expeditionDatabase.db;
  //final List<Map<String, dynamic>> maps = await db1.query('expeditions_table2');
  var map;
  map = {
    'name': "Villa",
    'id': 0,
    'date': DateTime.utc(2021, 7, 20).toString(),
    'hour': "09:00",
    'departure': "Ankara",
    'destination': "İstanbul",
    'seatsNumber': 40,
    'seatsList': "".padLeft(40, "0"),
    'seatsStyle': "2+2",
    'price': 70,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  //await expeditionDatabase.deleteExpeditions(4);

//print(await expeditionDatabase.);
  map = {
    'name': "Kamil Koç",
    'id': 1,
    'date': DateTime.utc(2021, 7, 23).toString(),
    'hour': "12:00",
    'departure': "Adana",
    'destination': "Mersin",
    'seatsNumber': 42,
    'seatsList': "".padLeft(42, "0"),
    'seatsStyle': "2+1",
    'price': 60,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  map = {
    'name': "Metro",
    'id': 2,
    'date': DateTime.utc(2021, 8, 10).toString(),
    'hour': "10:00",
    'departure': "Bilecik",
    'destination': "Ankara",
    'seatsNumber': 40,
    'seatsList': "".padLeft(40, "0"),
    'seatsStyle': "2+2",
    'price': 50,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  map = {
    'id': 3,
    'name': "Efe Tur",
    'date': DateTime.utc(2021, 8, 29).toString(),
    'hour': "14:00",
    'departure': "Bilecik",
    'destination': "Ankara",
    'seatsNumber': 40,
    'seatsList': "".padLeft(40, "0"),
    'seatsStyle': "2+2",
    'price': 70,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  map = {
    'name': "Villa",
    'id': 4,
    'date': DateTime.utc(2021, 7, 18).toString(),
    'hour': "11:00",
    'departure': "Ankara",
    'destination': "İstanbul",
    'seatsNumber': 40,
    'seatsList': "".padLeft(40, "0"),
    'seatsStyle': "2+2",
    'price': 50,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  map = {
    'name': "Kamil Koç",
    'id': 5,
    'date': DateTime.utc(2021, 7, 15).toString(),
    'hour': "14:00",
    'departure': "Ankara",
    'destination': "İstanbul",
    'seatsNumber': 39,
    'seatsList': "".padLeft(39, "0"),
    'seatsStyle': "2+1",
    'price': 90,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  map = {
    'name': "Metro",
    'id': 6,
    'date': DateTime.utc(2021, 7, 10).toString(),
    'hour': "23:00",
    'departure': "Mersin",
    'destination': "Kahramanmaraş",
    'seatsNumber': 44,
    'seatsList': "".padLeft(44, "0"),
    'seatsStyle': "2+2",
    'price': 60,
  };
  await expeditionDatabase.insertExpeditions(Expedition.fromMap(map));
  print(await expeditionDatabase.expeditionsList());
  print(await expeditionDatabase.ticketList());
  databasecontrol = false;
}
