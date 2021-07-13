import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/models/ticketInfo.dart';
import 'package:ticket_application/views/choosingSeat.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';

class ExpeditionCard extends StatefulWidget {
  final Expedition cardModel;
  final TicketInfo ticketModel;
  ExpeditionCard({Key? key, required this.cardModel, required this.ticketModel})
      : super(
          key: key,
        );

  @override
  ExpeditionCardState createState() => ExpeditionCardState();
}

class ExpeditionCardState extends State<ExpeditionCard> {
  onTapExpedition(BuildContext context) {
    Navigator.of(context)
        .push(new MaterialPageRoute(
            builder: (BuildContext context) => new ChoosingSeats(
                  cardModel: widget.cardModel,
                  ticketModel: widget.ticketModel,
                )))
        .then((_) => setState(() {
              widget.ticketModel.totalPrice = 0;
              for (int i = 0; i < widget.cardModel.seatsList.length; i++) {
                if (widget.cardModel.seatsList[i] == "3" ||
                    widget.cardModel.seatsList[i] == "4") {
                  ChoosingSeatsState.selectedSeats.remove(i);
                  //print(widget.cardModel.seatsList[i]);
                  widget.cardModel.seatsList =
                      widget.cardModel.seatsList.substring(0, i) +
                          '0' +
                          widget.cardModel.seatsList.substring(i + 1);
                  //widget.cardModel.seatsList[i] = 0;
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapExpedition(context),
      behavior: HitTestBehavior.translucent,
      child: Container(
          decoration: boxDecorationWidget(Colors.white),
          margin: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.cardModel.name,
                          style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(widget.cardModel.price.toString() + " ₺",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(selectedLanguage.departureTime,
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.black.withOpacity(0.6)))))
            ]),
            Row(children: [
              Icon(Icons.event_seat, size: 13),
              Text(widget.cardModel.seatsStyle,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 13.0, color: Colors.black)),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.access_time),
                            Text(widget.cardModel.hour,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black))
                          ])))
            ]),
            Row(children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Text(widget.cardModel.departure,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black)),
                        Icon(Icons.arrow_forward_ios),
                        Text(widget.cardModel.destination,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black)),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(Jiffy(widget.cardModel.date).yMMMMd,
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.black))))
                      ])))
            ])
          ])),
    );
  }
}
