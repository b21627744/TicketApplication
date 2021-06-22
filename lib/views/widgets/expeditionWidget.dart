import 'package:flutter/material.dart';

import 'package:ticket_application/models/expedition.dart';

class ExpeditionCard extends StatelessWidget {
  final Expedition cardModel;

  ExpeditionCard({Key key, this.cardModel})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              //margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        cardModel.name,
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        cardModel.price.toString() + " TL",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  /*Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.),
                    ),
                  ),*/
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.lock_clock),
                          Text(
                            cardModel.hour,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              //height: 13,
              //width: 320,
              child: Row(
                children: [
                  Icon(
                    Icons.event_seat,
                    size: 13,
                  ),
                  Text(
                    cardModel.seatsStyle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        cardModel.date.toString().substring(0, 10),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: [
                      Text(
                        cardModel.departure,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                      Text(
                        cardModel.destination,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
