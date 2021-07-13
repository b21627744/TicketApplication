import 'package:flutter/material.dart';

class TicketInfo {
  int id;
  int expeditionID;
  int totalPrice;

  String selectedSeatsNumbers;
  String selectedSeatsPayment;
  String passengerName;
  String passengerSurname;
  String passengerTC;

  String telNo;
  String mailAdreess;
  String cardNo;
  String cardSKT;
  String cardCVC;

  TicketInfo({
    required this.id,
    required this.expeditionID,
    required this.totalPrice,
    required this.selectedSeatsNumbers,
    required this.selectedSeatsPayment,
    required this.passengerName,
    required this.passengerSurname,
    required this.passengerTC,
    required this.telNo,
    required this.mailAdreess,
    required this.cardNo,
    required this.cardSKT,
    required this.cardCVC,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expeditionID': expeditionID,
      'totalPrice': totalPrice,
      'selectedSeatsNumbers': selectedSeatsNumbers,
      'selectedSeatsPayment': selectedSeatsPayment,
      'passengerName': passengerName,
      'passengerSurname': passengerSurname,
      'passengerTC': passengerTC,
      'telNo': telNo,
      'mailAdreess': mailAdreess,
      'cardNo': cardNo,
      'cardSKT': cardSKT,
      'cardCVC': cardCVC,
    };
  }

  @override
  String toString() {
    return 'Ticket{id: $id, expeditionID: $expeditionID, totalPrice: $totalPrice, passengerName: $passengerName, passengerSurname: $passengerSurname, passengerTC: $passengerTC, telNo: $telNo, mailAdreess: $mailAdreess, cardNo: $cardNo}';
  }
}
