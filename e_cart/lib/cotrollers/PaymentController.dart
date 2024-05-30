import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/payment_details_model.dart';

Future<String> fetchTransactionId() async {
  // Simulate fetching a transaction ID from your backend or generate it on the fly
  return Future.value("YourGeneratedTransactionId");
}

Future<String> sendPaymentDetails(PaymentDetails details) async {
  final url = Uri.parse(" https://f199-197-232-120-179.ngrok-free.app/stk");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'phone': details.number,
      'amount': details.amount,
      'trnxId': details.trnxId,
    }),
  );

  if (response.statusCode == 200) {
    // Successfully sent the payment details
    return "Payment initiated successfully";
  } else {
    // Handle the error
    throw Exception('Failed to initiate payment');
  }
}
