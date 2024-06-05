import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/payment_details_model.dart';

Future<String> fetchTransactionId() async {
  // Simulate fetching a transaction ID from your backend or generate it on the fly
  return Future.value("YourGeneratedTransactionId");
}

Future<String> sendPaymentDetails(PaymentDetails details) async {
  final url = Uri.parse("http://192.168.1.10:8000/stk");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'phone': details.number,
        'amount': details.amount.round(), // Ensure amount is formatted correctly
        'trnxId': details.trnxId,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully sent the payment details
      return "Payment initiated successfully";
    } else {
      // Log response details for debugging
      print('Failed to initiate payment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to initiate payment: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the HTTP request
    print('Exception occurred: $e');
    throw Exception('Failed to initiate payment: $e');
  }
}
