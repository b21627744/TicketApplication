import 'package:flutter/material.dart';
import 'package:ticket_application/views/expeditionSearch.dart';

class PaymentResult extends StatefulWidget {
  PaymentResult({Key? key}) : super(key: key);

  @override
  PaymentResultState createState() => PaymentResultState();
}

Widget bodyColumn(BuildContext context) =>
    Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Payment successfully completed.", style: TextStyle(fontSize: 19)),
      SizedBox(height: 32),
      ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => new ExpeditionSearch()),
                (Route<dynamic> route) => false);
          },
          child: Text("Back To Main Page",
              style: TextStyle(color: Colors.black, fontSize: 20)),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)))))
    ]);

class PaymentResultState extends State<PaymentResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 45, title: Text("Payment Result")),
        body: Container(
            color: Colors.white, child: Center(child: bodyColumn(context))));
  }
}
