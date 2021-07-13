import 'package:flutter/material.dart';
import 'package:ticket_application/models/ticketInfo.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/widgets/expeditionWidget.dart';

class ListAllExpenditions extends StatefulWidget {
  ListAllExpenditions({Key? key}) : super(key: key);

  @override
  ListAllExpenditionsState createState() => ListAllExpenditionsState();
}

class ListAllExpenditionsState extends State<ListAllExpenditions> {
  List<ExpeditionCard> allExpeditions = [];
  List<ExpeditionCard> searchExpeditions() {
    allExpeditions = [];

    ExpeditionSearch.expeditionList.forEach((element) {
      allExpeditions.add(ExpeditionCard(
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
        ),
      ));
    });

    return allExpeditions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          title: Text(selectedLanguage.listAllTitle),
        ),
        body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: searchExpeditions().toList()))));
  }
}
