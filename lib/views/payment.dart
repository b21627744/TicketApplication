import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_application/main.dart';
import 'package:ticket_application/models/expedition.dart';
import 'package:ticket_application/models/ticketInfo.dart';
import 'package:ticket_application/views/choosingSeat.dart';
import 'package:ticket_application/views/expeditionSearch.dart';
import 'package:ticket_application/views/paymentResult.dart';
import 'package:ticket_application/views/widgets/boxDecorationWidget.dart';
import 'package:ticket_application/views/widgets/inputFormatter.dart';
import 'package:ticket_application/views/widgets/selectExpedition.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget with ChangeNotifier {
  final Expedition cardModel;
  final TicketInfo ticketModel;
  Payment({Key? key, required this.cardModel, required this.ticketModel})
      : super(key: key);

  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  List<TextEditingController> textEditingControllerList = [];

  List<Color> selectionColor = [];
  List<int> validateFormPassenger = [];
  List<bool> selectedSeatsVisible = [];
  List<bool> validateFormField = [];

  bool visibleContact = true;
  bool visiblePassenger = true;
  bool visiblePayment = true;

  bool visibleContactValid = false;
  bool visiblePassengerValid = false;
  bool visiblePaymentValid = false;

  Color selectedColor = Colors.blue.shade100;
  Color unSelectedColor = Colors.white;
  Color femaleColor = Color(0xffe29deb);
  Color maleColor = Color(0xff82e2ed);

  @override
  initState() {
    super.initState();
    initializeVariables();
  }

  initializeVariables() {
    for (int i = 0; i < widget.cardModel.seatsList.length; i++) {
      if (widget.cardModel.seatsList[i] == "3" ||
          widget.cardModel.seatsList[i] == "4") {
        selectedSeatsVisible.add(false);
        selectionColor.add(unSelectedColor);
      }
    }
    textEditingControllerList = List.generate(
        5 + selectedSeatsVisible.length * 3, (i) => TextEditingController());
    selectionColor[0] = selectedColor;
    selectedSeatsVisible[0] = true;
    validateFormField = List.filled(5 + selectedSeatsVisible.length * 3, true);
    validateFormPassenger = List.filled(selectedSeatsVisible.length * 3, 1);
  }

  bool isValid(List<TextEditingController> textEditingControllerList, int i) {
    if (textEditingControllerList[i].text.isEmpty) {
      setState(() {
        validateFormField[i] = false;
      });
      return false;
    } else {
      setState(() {
        validateFormField[i] = true;
      });
      return true;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value != "") {
      return 'Enter a valid email address';
    } else {
      return "";
    }
  }

  bool selectedSeatValidController(int i, StateSetter setState) {
    if (validateFormPassenger[(i * 3)] == 2 &&
        validateFormPassenger[1 + (i * 3)] == 2 &&
        validateFormPassenger[2 + (i * 3)] == 2)
      return true;
    else
      return false;
  }

  bool selectedSeatCheck(int i) {
    if (validateFormPassenger[(i * 3)] == 2 &&
        validateFormPassenger[1 + (i * 3)] == 2 &&
        validateFormPassenger[2 + (i * 3)] == 2) {
      return true;
    } else {
      return false;
    }
  }

  bool selectedSeatClear(int i) {
    if (validateFormPassenger[(i * 3)] == 3 ||
        validateFormPassenger[1 + (i * 3)] == 3 ||
        validateFormPassenger[2 + (i * 3)] == 3) {
      return true;
    } else {
      return false;
    }
  }

  bool contactControl(bool controller) {
    if (isValid(textEditingControllerList, 0) == false ||
        (validateEmail(textEditingControllerList[0].text) != "")) {
      controller = false;
      visibleContactValid = true;
      visibleContact = true;
    }
    if (isValid(textEditingControllerList, 1) == false ||
        (textEditingControllerList[1].text.length != 12)) {
      controller = false;
      visibleContactValid = true;
      visibleContact = true;
    }
    return controller;
  }

  bool passengerControl(bool controller) {
    for (int i = 0; i < selectedSeatsVisible.length; i++) {
      if (isValid(textEditingControllerList, 3 * i + 2) == false) {
        controller = false;
        visiblePassengerValid = true;
        visiblePassenger = true;
      }
      if (isValid(textEditingControllerList, 3 * i + 3) == false) {
        controller = false;
        visiblePassengerValid = true;
        visiblePassenger = true;
      }
      if (isValid(textEditingControllerList, 3 * i + 4) == false ||
          (textEditingControllerList[3 * i + 4].text.length != 11)) {
        controller = false;
        visiblePassengerValid = true;
        visiblePassenger = true;
      }
    }
    return controller;
  }

  bool paymentControl(bool controller) {
    if (isValid(textEditingControllerList,
                (selectedSeatsVisible.length * 3) + 2) ==
            false ||
        textEditingControllerList[(selectedSeatsVisible.length * 3) + 2]
                .text
                .length !=
            19) {
      controller = false;
      visiblePaymentValid = true;
      visiblePayment = true;
    }
    if (isValid(textEditingControllerList,
                (selectedSeatsVisible.length * 3) + 3) ==
            false ||
        textEditingControllerList[(selectedSeatsVisible.length * 3) + 3]
                .text
                .length !=
            5) {
      controller = false;
      visiblePaymentValid = true;
      visiblePayment = true;
    }
    if (isValid(textEditingControllerList,
                (selectedSeatsVisible.length * 3) + 4) ==
            false ||
        textEditingControllerList[(selectedSeatsVisible.length * 3) + 4]
                .text
                .length !=
            3) {
      controller = false;
      visiblePaymentValid = true;
      visiblePayment = true;
    }
    return controller;
  }

  bool allValid(StateSetter setState) {
    bool controller = true;
    visibleContactValid = false;
    visiblePassengerValid = false;
    visiblePaymentValid = false;
    bool contactBool = contactControl(controller);
    bool contactPassenger = passengerControl(controller);
    bool contactPayment = paymentControl(controller);
    for (int i = 0; i < validateFormPassenger.length; i++)
      if (validateFormPassenger[i] == 1) validateFormPassenger[i] = 3;
    setState(() {});
    if (contactBool == true &&
        contactPassenger == true &&
        contactPayment == true) return true;
    return false;
  }

  payResultInsertDatabase() async {
    widget.ticketModel.passengerName = "";
    widget.ticketModel.passengerSurname = "";
    widget.ticketModel.passengerTC = "";
    widget.ticketModel.selectedSeatsNumbers = "";
    widget.ticketModel.mailAdreess = textEditingControllerList[0].text;
    widget.ticketModel.telNo = textEditingControllerList[1].text;
    widget.ticketModel.cardNo =
        textEditingControllerList[3 * selectedSeatsVisible.length + 2].text;
    widget.ticketModel.cardSKT =
        textEditingControllerList[3 * selectedSeatsVisible.length + 3].text;
    widget.ticketModel.cardCVC =
        textEditingControllerList[3 * selectedSeatsVisible.length + 4].text;

    for (int i = 0; i < selectedSeatsVisible.length; i++) {
      widget.ticketModel.passengerName = widget.ticketModel.passengerName +
          "," +
          textEditingControllerList[3 * i + 2].text;
      widget.ticketModel.passengerSurname =
          widget.ticketModel.passengerSurname +
              "," +
              textEditingControllerList[3 * i + 3].text;
      widget.ticketModel.passengerTC = widget.ticketModel.passengerTC +
          "," +
          textEditingControllerList[3 * i + 4].text;

      await expeditionDatabase.updateExpeditions(widget.cardModel);
      widget.ticketModel.id = ExpeditionSearch.ticketId;
      await expeditionDatabase.insertTicket(widget.ticketModel);
    }
  }

  onPay() => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PaymentResult()),
      (Route<dynamic> route) => false);

  payControl() async {
    if (allValid(setState) == true) {
      for (int i = 0; i < widget.cardModel.seatsList.length; i++) {
        if (widget.cardModel.seatsList[i] == "3") {
          widget.cardModel.seatsList =
              widget.cardModel.seatsList.substring(0, i) +
                  '5' +
                  widget.cardModel.seatsList.substring(i + 1);
          ChoosingSeatsState.selectedSeats.remove(i);
        }
        if (widget.cardModel.seatsList[i] == "4") {
          widget.cardModel.seatsList =
              widget.cardModel.seatsList.substring(0, i) +
                  '6' +
                  widget.cardModel.seatsList.substring(i + 1);
          ChoosingSeatsState.selectedSeats.remove(i);
        }
      }
      await payResultInsertDatabase();
      onPay();
    }
  }

  onChangeForm(int i, String value) {
    if (value.isNotEmpty) validateFormField[i] = true;
    if (value.isEmpty) validateFormField[i] = false;
    setState(() {});
  }

  onChangeFormPassenger(int i, String value, bool tc, int validation) {
    if (value.isNotEmpty) {
      validateFormField[i + 2] = true;
      validateFormPassenger[i] = 2;
      if (tc == true) {
        if (textEditingControllerList[i + 2].text.length != 11)
          validateFormPassenger[i] = 3;
      }
    }
    if (value.isEmpty) {
      validateFormField[i + 2] = false;
      validateFormPassenger[i] = 3;
    }
    setState(() {});
    selectedSeatValidController(validation, setState);
  }

  String? errorTextEmail() {
    if (validateFormField[0] == true) {
      if (validateEmail(textEditingControllerList[0].text) == "") {
        return null;
      } else {
        return validateEmail(textEditingControllerList[0].text);
      }
    } else {
      return 'Value Can\'t Be Empty';
    }
  }

  String? errorTextWithControl(int i, int len, String validText) {
    if (validateFormField[i] == true) {
      if (textEditingControllerList[i].text.length == len ||
          textEditingControllerList[i].text.length == 0) {
        return null;
      } else {
        return "Enter a valid " + validText;
      }
    } else {
      return 'Value Can\'t Be Empty';
    }
  }

  String? errorTextWithoutControl(int i) {
    if (validateFormField[i] == true)
      return null;
    else
      return 'Value Can\'t Be Empty';
  }

  Widget emailFormField() => TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: textEditingControllerList[0],
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          icon: const Icon(Icons.email, color: Colors.black),
          hintText: 'user@gmail.com',
          labelText: 'Email',
          errorText: errorTextEmail()),
      onChanged: (String value) async => onChangeForm(0, value));

  Widget phoneFormField() => TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
            MaskedTextInputFormatter(mask: 'xxx-xxx-xxxx', separator: '-')
          ],
          controller: textEditingControllerList[1],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              fillColor: Colors.white,
              border: UnderlineInputBorder(),
              filled: true,
              hintText: '5XX-XXX-XXXX',
              labelText: 'Phone Number',
              errorText: errorTextWithControl(1, 12, "phone number"),
              icon: const Icon(Icons.phone, color: Colors.black)),
          onChanged: (String value) async => onChangeForm(1, value));

  Widget nameFormField(int i) => TextFormField(
      controller: textEditingControllerList[2 + (i * 3)],
      inputFormatters: [
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          icon: const Icon(
            Icons.perm_identity,
            color: Colors.black,
          ),
          hintText: 'Your name',
          labelText: 'Name',
          errorText: errorTextWithoutControl(2 + (i * 3))),
      onChanged: (String value) async =>
          onChangeFormPassenger((i * 3), value, false, i));

  Widget surnameFormField(int i) => TextFormField(
      controller: textEditingControllerList[3 + (i * 3)],
      keyboardType: TextInputType.text,
      inputFormatters: [
        new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: UnderlineInputBorder(),
        filled: true,
        icon: const Icon(
          Icons.perm_identity,
          color: Colors.black,
        ),
        hintText: 'Your surname',
        labelText: 'Surname',
        errorText: errorTextWithoutControl(3 + (i * 3)),
      ),
      onChanged: (String value) async =>
          onChangeFormPassenger((i * 3 + 1), value, false, i));

  Widget tcFormField(int i) => TextFormField(
      controller: textEditingControllerList[4 + (i * 3)],
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: UnderlineInputBorder(),
        filled: true,
        icon: const Icon(
          Icons.face,
          color: Colors.black,
        ),
        hintText: '***********',
        labelText: 'TC',
        errorText: errorTextWithControl(4 + (i * 3), 11, "TC"),
      ),
      onChanged: (String value) async =>
          onChangeFormPassenger((i * 3 + 2), value, true, i),
      maxLength: 11);

  Widget cardNoTextField() => TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
        MaskedTextInputFormatter(mask: 'xxxx-xxxx-xxxx-xxxx', separator: '-'),
      ],
      controller:
          textEditingControllerList[3 * selectedSeatsVisible.length + 2],
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          icon: const Icon(Icons.credit_card, color: Colors.black),
          hintText: '****-****-****-****',
          labelText: 'Card No',
          errorText: errorTextWithControl(
              2 + selectedSeatsVisible.length * 3, 19, "Card No")),
      onChanged: (String value) async =>
          onChangeForm(2 + selectedSeatsVisible.length * 3, value));

  Widget cardSKTFormField() => Flexible(
      child: TextFormField(
          controller:
              textEditingControllerList[3 * selectedSeatsVisible.length + 3],
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9/]+')),
            MaskedTextInputFormatter(mask: 'xx/xx', separator: '/')
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              fillColor: Colors.white,
              border: UnderlineInputBorder(),
              filled: true,
              hintText: 'MM/YY',
              labelText: 'Expiration Date',
              errorText: errorTextWithControl(
                  3 + selectedSeatsVisible.length * 3, 5, "expiration date")),
          onChanged: (String value) async =>
              onChangeForm(3 + selectedSeatsVisible.length * 3, value),
          maxLength: 5));

  Widget cardCVCFormField() => Flexible(
          child: TextFormField(
              inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          ],
              controller: textEditingControllerList[
                  3 * selectedSeatsVisible.length + 4],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: UnderlineInputBorder(),
                  filled: true,
                  hintText: '***',
                  labelText: 'CVC2',
                  errorText: errorTextWithControl(
                      4 + selectedSeatsVisible.length * 3, 3, "CVC")),
              onChanged: (String value) async =>
                  onChangeForm(4 + selectedSeatsVisible.length * 3, value),
              maxLength: 3));

  Widget contactInfoWidget() => Visibility(
      visible: visibleContact,
      child: Container(
          alignment: Alignment.center,
          decoration: boxDecorationWidget(Colors.white),
          margin: EdgeInsets.only(top: 32, right: 32, left: 32),
          padding: EdgeInsets.all(32),
          child: Column(children: [
            Visibility(
                visible: visibleContactValid, child: SizedBox(height: 16)),
            emailFormField(),
            phoneFormField(),
          ])));

  Widget contactInfoTitle() => GestureDetector(
      onTap: () {
        setState(() {
          visibleContact = !visibleContact;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.7), //Colors.yellow.shade500,
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.only(top: 16, right: 64, left: 64),
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("CONTACT INFORMATIONS"),
              Icon(Icons.arrow_drop_down)
            ]),
            emptyFieldsWidget(visibleContactValid),
          ])));

  Widget passengerIcon(bool bool, int i, IconData icon, Color color) =>
      Visibility(
          visible: bool,
          child: Container(
              width: 140,
              alignment: Alignment.topRight,
              child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: selectionColor[i],
                    border: Border.all(
                        color: Colors.black.withOpacity(0.6), width: 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Icon(icon, size: 22, color: color))));

  Widget passengerInfoWidget() => Visibility(
      visible: visiblePassenger,
      child: Container(
          alignment: Alignment.center,
          decoration: boxDecorationWidget(Colors.white),
          margin: EdgeInsets.only(top: 32, right: 32, left: 32),
          padding: EdgeInsets.all(32),
          child: Column(children: [
            Visibility(
                visible: visiblePassengerValid, child: SizedBox(height: 16)),
            Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
              if (ChoosingSeatsState.selectedSeats.length != 1)
                for (int i = 0;
                    i < ChoosingSeatsState.selectedSeats.length;
                    i++)
                  Stack(children: [
                    Container(
                      width: 120,
                      height: 35,
                      margin:
                          EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: selectionColor[i],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            ((selectedSeatsVisible[i])
                                ? BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: Offset(2, 3))
                                : BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1.5,
                                    blurRadius: 2,
                                    offset: Offset(2, 3)))
                          ]),
                      child: Container(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              for (int j = 0; j < selectionColor.length; j++) {
                                selectedSeatsVisible[j] = false;
                                selectionColor[j] = unSelectedColor;
                              }
                              selectedSeatsVisible[i] = true;
                              selectionColor[i] = selectedColor;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                "( Seat No: " +
                                    (ChoosingSeatsState.selectedSeats[i] + 1)
                                        .toString() +
                                    " ) ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: selectedSeatCheck(i)
                                        ? Colors.green.shade700
                                        : (selectedSeatClear(i)
                                            ? Colors.red.shade700
                                            : Colors.black))),
                          ),
                        ),
                      ),
                    ),
                    passengerIcon(selectedSeatCheck(i), i, Icons.check_rounded,
                        Colors.green.shade700),
                    passengerIcon(selectedSeatClear(i), i, Icons.close_rounded,
                        Colors.red.shade700),
                  ])
            ]),
            for (int i = 0; i < selectedSeatsVisible.length; i++)
              Visibility(
                  visible: selectedSeatsVisible[i],
                  child: Column(children: [
                    nameFormField(i),
                    surnameFormField(i),
                    tcFormField(i),
                  ]))
          ])));

  Widget passengerInfoTitle() => GestureDetector(
      onTap: () {
        setState(() {
          visiblePassenger = !visiblePassenger;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.only(top: 16, right: 64, left: 64),
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PASSENGER(S) INFORMATIONS"),
                Icon(Icons.arrow_drop_down),
              ],
            ),
            emptyFieldsWidget(visiblePassengerValid),
          ])));

  Widget paymentInfoWidget() => Visibility(
      visible: visiblePayment,
      child: Container(
          alignment: Alignment.center,
          decoration: boxDecorationWidget(Colors.white),
          margin: EdgeInsets.only(top: 32, right: 32, left: 32),
          padding: EdgeInsets.all(32),
          child: Column(children: [
            Visibility(
              visible: visiblePaymentValid,
              child: SizedBox(height: 16),
            ),
            cardNoTextField(),
            Row(children: [
              cardSKTFormField(),
              Container(height: 20, width: 1, color: Colors.black),
              cardCVCFormField(),
            ])
          ])));

  Widget paymentInfoTitle() => GestureDetector(
      onTap: () {
        setState(() {
          visiblePayment = !visiblePayment;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.only(top: 16, right: 64, left: 64),
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("PAYMENT INFORMATIONS"),
              Icon(Icons.arrow_drop_down)
            ]),
            emptyFieldsWidget(visiblePaymentValid),
          ])));

  Widget emptyFieldsWidget(bool visible) => Visibility(
        visible: visible,
        child: Text("( There are empty or wrong fields. )",
            style: TextStyle(color: Colors.red)),
      );

  Widget btnPay() => BouncingWidget(
      duration: Duration(milliseconds: 500),
      scaleFactor: 1.2,
      onPressed: () async {
        await payControl();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        margin: EdgeInsets.all(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [BoxShadow(blurRadius: 8.0, offset: Offset(0.0, 5.0))],
          /*gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow.shade200, Colors.yellow.shade700])*/
        ),
        child: Text(widget.ticketModel.totalPrice.toString() + " ₺  |  PAY",
            style: TextStyle(fontSize: 20, color: Colors.black)),
      ));

  Widget bodyContainer(BuildContext context) => SingleChildScrollView(
          child: Column(children: [
        selectedExpedition(widget.cardModel, widget.ticketModel),
        Stack(
          children: [contactInfoWidget(), contactInfoTitle()],
        ),
        Stack(
          children: [passengerInfoWidget(), passengerInfoTitle()],
        ),
        Stack(
          children: [paymentInfoWidget(), paymentInfoTitle()],
        ),
        btnPay(),
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          title: Text("Payment"),
        ),
        body: bodyContainer(context));
  }
}
