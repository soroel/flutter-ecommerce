import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cotrollers/PaymentController.dart';
import '../cotrollers/productController.dart';
import '../model/payment_details_model.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _numberController = TextEditingController();
  final ProductController productController = Get.put(ProductController());
  String? _trnxId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransactionId();
  }

  void _fetchTransactionId() async {
    try {
      final trnxId = await fetchTransactionId();
      setState(() {
        _trnxId = trnxId;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _submitPayment() async {
    final number = _numberController.text;
    final amount = productController.getTotalPrice();
    print("Number: $number, Amount: $amount, Transaction ID: $_trnxId");

    if (number.isEmpty || amount <= 0 || _trnxId == null) {
      // Handle invalid input
      return;
    }

    try {
      final response = await sendPaymentDetails(PaymentDetails(
        number: number,
        trnxId: _trnxId!,
        amount: amount,
      ));
      // Handle the response (success or failure)
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    } catch (e) {
      // Handle error
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Payment'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _numberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(labelText: 'Transaction ID', hintText: _trnxId ?? ''),
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(labelText: 'Amount', hintText: '\$${productController.getTotalPrice()}'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPayment,
              child: Text('Submit Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
