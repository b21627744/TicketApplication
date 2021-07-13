import 'package:flutter/material.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/models/ticketInfo.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/payment.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';
import 'package:ticket_application/views/widgets/expeditionWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_application/views/widgets/selectExpedition.dart';
import 'package:ticket_application/views/widgets/showDialog.dart';

class ChoosingSeats extends StatefulWidget {
  final Expedition cardModel;
  final TicketInfo ticketModel;
  ChoosingSeats({Key? key, required this.cardModel, required this.ticketModel})
      : super(key: key);

  @override
  ChoosingSeatsState createState() => ChoosingSeatsState();
}

class ChoosingSeatsState extends State<ChoosingSeats> {
  static List<int> selectedSeats = [];

  List<ExpeditionCard> allExpeditions = [];

  double squareHeight = 35;
  double squareWidth = 35;

  Color busColor = Colors.white;
  Color femaleColor = Color(0xffe29deb);
  Color maleColor = Color(0xff82e2ed);
  Color soldColor = Color(0xfff7753e);
  Color emptyColor = Color(0xff878484).withOpacity(0.8);

  onContinue(BuildContext context) {
    if (widget.ticketModel.totalPrice != 0) {
      Navigator.of(context)
          .push(new MaterialPageRoute(
              builder: (BuildContext context) => new Payment(
                    cardModel: widget.cardModel,
                    ticketModel: widget.ticketModel,
                  )))
          .then((_) => setState(() {}));
    } else {
      showDialogWidget(context, selectedLanguage.alertChoose);
    }
  }

  onCancelSeat(StateSetter setState, int seatStyle, int i, int j) {
    setState(() {
      widget.cardModel.seatsList =
          widget.cardModel.seatsList.substring(0, j + seatStyle * i) +
              '0' +
              widget.cardModel.seatsList.substring(j + seatStyle * i + 1);
      widget.ticketModel.totalPrice -= widget.cardModel.price;
      ChoosingSeatsState.selectedSeats.remove(j + seatStyle * i);
    });
  }

  selectSeat(StateSetter setState, String seat, int i, int j, int seatStyle) {
    setState(() {
      widget.cardModel.seatsList =
          widget.cardModel.seatsList.substring(0, j + seatStyle * i) +
              seat +
              widget.cardModel.seatsList.substring(j + seatStyle * i + 1);
      widget.ticketModel.totalPrice += widget.cardModel.price;
      ChoosingSeatsState.selectedSeats.add(j + seatStyle * i);
    });
    Navigator.pop(context);
  }

  Widget soldSeat(
          BuildContext context, int i, int j, int seatStyle, Color color) =>
      GestureDetector(
        onTap: () {
          showDialogWidget(context, selectedLanguage.alertSold);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: emptyColor, width: 1.5),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          height: squareHeight,
          width: squareWidth,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text((j + seatStyle * i + 1).toString())]),
        ),
      );

  Widget selectedSeat(
          BuildContext context, int i, int j, int seatStyle, Color color) =>
      GestureDetector(
        onTap: () => onCancelSeat(setState, seatStyle, i, j),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(8.0)),
              alignment: Alignment.center,
              margin: EdgeInsets.all(8),
              height: squareHeight,
              width: squareWidth,
              child: Text((j + seatStyle * i + 1).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Stack(
              children: [
                Container(
                    margin: EdgeInsets.all(2),
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(128.0))),
                Icon(Icons.cancel_outlined)
              ],
            )
          ],
        ),
      );

  Widget exampleSeats(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            decoration: BoxDecoration(
                color: femaleColor, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.all(8),
            height: 25,
            width: 25),
        Column(children: [
          Container(
              margin: EdgeInsets.only(right: 8, left: 8),
              child: Text(selectedLanguage.sold)),
          Container(
              margin: EdgeInsets.only(right: 8, left: 8),
              child: Text("(" + selectedLanguage.female + ")"))
        ]),
        Container(
            decoration: BoxDecoration(
                color: maleColor, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.all(8),
            height: 25,
            width: 25),
        Column(children: [
          Container(
              margin: EdgeInsets.only(right: 8, left: 8),
              child: Text(selectedLanguage.sold)),
          Container(
              margin: EdgeInsets.only(right: 8, left: 8),
              child: Text("(" + selectedLanguage.male + ")"))
        ]),
        Container(
            decoration: BoxDecoration(
                color: emptyColor, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.all(8),
            height: 25,
            width: 25),
        Container(
            margin: EdgeInsets.all(8), child: Text(selectedLanguage.empty))
      ]);

  Widget busWidget(BuildContext context) {
    if (widget.cardModel.seatsStyle == "2+1")
      return seatStyleWidget(context, 3, 64, 140);
    else
      return seatStyleWidget(context, 4, 32, 190);
  }

  Widget scrollContainer(BuildContext context, double paddingLeft) => Container(
      padding: EdgeInsets.only(left: paddingLeft, right: 8),
      child: Column(children: [
        Icon(Icons.keyboard_arrow_up),
        Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: busColor,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(30)),
            child: Wrap(
                runSpacing: 30,
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                children: (selectedLanguage.scroll)
                    .split("")
                    .map((string) => Text(string,
                        style: TextStyle(fontSize: 16, color: Colors.black)))
                    .toList())),
        Icon(Icons.keyboard_arrow_down),
      ]));

  Widget bottomSheetSelection(StateSetter setState, String seat, int i, int j,
          int seatStyle, Color color, String text) =>
      ListTile(
        onTap: () => selectSeat(setState, seat, i, j, seatStyle),
        leading: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.all(8),
            height: squareHeight,
            width: squareWidth,
            child: Text((j + seatStyle * i + 1).toString())),
        title: new Text(text),
      );

  Future<dynamic> bottomSheetSelect(
          BuildContext context, int i, int j, int seatStyle) =>
      showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                  margin: EdgeInsets.all(16),
                  child: Text(selectedLanguage.selectGender)),
              bottomSheetSelection(setState, '3', i, j, seatStyle, femaleColor,
                  selectedLanguage.female),
              bottomSheetSelection(setState, '4', i, j, seatStyle, maleColor,
                  selectedLanguage.male)
            ]);
          });

  Widget emptySeat(BuildContext context, int i, int j, int seatStyle) =>
      GestureDetector(
        onTap: () => bottomSheetSelect(context, i, j, seatStyle),
        child: Container(
          decoration: BoxDecoration(
            color: emptyColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          height: squareHeight,
          width: squareWidth,
          child: Text((j + seatStyle * i + 1).toString(),
              style: TextStyle(color: Colors.white)),
        ),
      );

  Widget busSeats(int seatStyle, double marginRight) => Column(
        children: <Widget>[
          SizedBox(height: 16),
          Container(
              margin: EdgeInsets.only(right: marginRight, bottom: 8),
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset('assets/steering-wheel.svg',
                  height: squareHeight, width: squareWidth)),
          Column(children: [
            for (int i = 0;
                i < widget.cardModel.seatsList.length / seatStyle;
                i++)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int j = 0; j < seatStyle; j++)
                  Row(children: <Widget>[
                    if (j == seatStyle - 2)
                      Container(
                          margin: EdgeInsets.all(8),
                          height: 20,
                          width: 20,
                          color: busColor),
                    if (widget.cardModel.seatsList[j + seatStyle * i] == "0")
                      emptySeat(context, i, j, seatStyle),
                    if (widget.cardModel.seatsList[j + seatStyle * i] == "3")
                      selectedSeat(context, i, j, seatStyle, femaleColor),
                    if (widget.cardModel.seatsList[j + seatStyle * i] == "4")
                      selectedSeat(context, i, j, seatStyle, maleColor),
                    if (widget.cardModel.seatsList[j + seatStyle * i] == "5")
                      soldSeat(context, i, j, seatStyle, femaleColor),
                    if (widget.cardModel.seatsList[j + seatStyle * i] == "6")
                      soldSeat(context, i, j, seatStyle, maleColor)
                  ])
              ])
          ])
        ],
      );

  Widget busContainer(int seatStyle, double marginRight) => Container(
        height: 445,
        decoration: BoxDecoration(
            color: busColor,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(1, 1))
            ]),
        margin: EdgeInsets.only(right: 32, top: 16),
        padding: EdgeInsets.only(right: 16, left: 16),
        child: SingleChildScrollView(
          child: busSeats(seatStyle, marginRight),
        ),
      );
  Widget btnContinue(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 16, bottom: 32),
        //color: Colors.black,
        child: ElevatedButton(
            onPressed: () => onContinue(context),
            child: Text(selectedLanguage.continueButton,
                style: TextStyle(color: Colors.black, fontSize: 20)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              //backgroundColor: MaterialStateProperty.all(Colors.yellow)
            )),
      );

  Widget seatStyleWidget(BuildContext context, int seatStyle,
          double paddingLeft, double marginRight) =>
      Row(
        children: [
          scrollContainer(context, paddingLeft),
          busContainer(seatStyle, marginRight),
        ],
      );

  Widget bodyContainer(BuildContext context) => SingleChildScrollView(
          child: Column(children: [
        selectedExpedition(widget.cardModel, widget.ticketModel),
        exampleSeats(context),
        SizedBox(height: 16),
        busWidget(context),
        btnContinue(context),
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          title: Text(selectedLanguage.choosingSeatTitle),
        ),
        body: bodyContainer(context));
  }
}
