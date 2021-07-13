import 'package:flutter/material.dart';
import 'package:ticket_application/models/ticketInfo.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/expeditionSearchResult.dart';
import 'package:ticket_application/views/widgets/expeditionWidget.dart';
import 'package:ticket_application/views/widgets/showDialog.dart';

onBtnSearch(BuildContext context, StateSetter setStatee, bool controller) {
  String alertText = "";
  if (ExpeditionSearchState.departure.name != "" &&
      ExpeditionSearchState.destination.name != "") {
    if (ExpeditionSearchState.departure.name ==
        ExpeditionSearchState.destination.name) {
      showDialogWidget(context, selectedLanguage.alertSameDirections);
    } else {
      searchExpedition(
          ExpeditionSearchState.departure.name,
          ExpeditionSearchState.destination.name,
          ExpeditionSearchState.currentDate,
          setStatee);
      if (controller == true)
        Navigator.of(context)
            .push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new ExpeditionSearchResult()))
            .then((_) => setStatee(() {}));
      else
        Navigator.pop(context);
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

Widget btnSearchContainer(
        BuildContext context, StateSetter setStatee, bool controller) =>
    Container(
      margin: EdgeInsets.only(right: 32, left: 32),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: btnSearch(context, setStatee, controller),
    );

Widget btnSearch(
        BuildContext context, StateSetter setStatee, bool controller) =>
    ElevatedButton(
      onPressed: () => onBtnSearch(context, setStatee, controller),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selectedLanguage.searchButton,
                style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(width: 16),
            Icon(Icons.search),
          ],
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)))),
    );

Future<void> searchExpedition(String departure, String destination,
    DateTime date, StateSetter setState) async {
  setState(() {
    ExpeditionSearch.searchedExpeditions = [];
  });

  ExpeditionSearch.expeditionList.forEach((element) {
    if (element.departure == departure &&
        element.destination == destination &&
        element.date.toString().substring(0, 10) ==
            date.toString().substring(0, 10)) {
      setState(() {
        ExpeditionSearch.searchedExpeditions.add(ExpeditionCard(
            cardModel: element,
            ticketModel: new TicketInfo(
              id: ExpeditionSearch.ticketId,
              expeditionID: element.id,
              totalPrice: 0,
              selectedSeatsNumbers: "",
              selectedSeatsPayment: "",
              passengerName: "",
              passengerSurname: "",
              passengerTC: "",
              telNo: "",
              mailAdreess: "",
              cardNo: "",
              cardSKT: "",
              cardCVC: "",
            )));
      });
    }
  });
}
