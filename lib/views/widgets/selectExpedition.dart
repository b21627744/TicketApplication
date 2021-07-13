import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/models/ticketInfo.dart';
import 'package:ticket_application/views/choosingSeat.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';

Widget selectedExpedition(Expedition expedition, TicketInfo ticket) {
  Color femaleColor = Color(0xffe29deb);
  Color maleColor = Color(0xff82e2ed);
  return Container(
      decoration: boxDecorationWidget(Colors.white),
      margin: EdgeInsets.only(bottom: 8, top: 16, right: 16, left: 16),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(children: [
            Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(expedition.name,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)))),
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time),
                            Text(expedition.hour,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black))
                          ])
                    ]))),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(Jiffy(expedition.date).yMMMMd,
                        style: TextStyle(fontSize: 14.0, color: Colors.black))))
          ]),
          Row(
            children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Text(expedition.departure,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black)),
                        Icon(Icons.arrow_forward_ios),
                        Text(expedition.destination,
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black))
                      ])))
            ],
          ),
          Divider(color: Colors.black),
          Row(children: [
            Expanded(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.people_alt_rounded),
                          Text(
                              " " +
                                  ChoosingSeatsState.selectedSeats.length
                                      .toString() +
                                  " passenger",
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black)),
                          Text(" (Seat Number : ",
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black)),
                          for (int i = 0; i < expedition.seatsList.length; i++)
                            Column(children: [
                              if (expedition.seatsList[i] == "3")
                                Container(
                                    decoration: BoxDecoration(
                                      color: femaleColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(4),
                                    height: 18,
                                    width: 18,
                                    child: Text((i + 1).toString())),
                              if (expedition.seatsList[i] == "4")
                                Container(
                                  decoration: BoxDecoration(
                                    color: maleColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(4),
                                  height: 18,
                                  width: 18,
                                  child: Text((i + 1).toString()),
                                )
                            ]),
                          Text(") ",
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black))
                        ])))
          ]),
          Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Total Price: "),
                Text(ticket.totalPrice.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(" ₺ ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ]))
        ],
      ));
}
