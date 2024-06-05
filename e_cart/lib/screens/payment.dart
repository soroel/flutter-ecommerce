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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter all the details correctly.')));
      return;
    }

    // Confirmation dialog
    final confirm = await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Confirm Payment'),
            content: Text(
                'Send \$${amount.toStringAsFixed(2)} to account 0794824427?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Confirm'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      try {
        final response = await sendPaymentDetails(PaymentDetails(
          number: number,
          trnxId: _trnxId!,
          amount: amount,
        ));
        // Handle the response (success or failure)
        print(response);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response)));
      } catch (e) {
        // Handle error
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Payment'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _numberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitPayment,
                    child: Text('Submit Payment'),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showPaymentDialog(context);
          },
          child: Text('Set Up Payment'),
        ),
      ),
    );
  }
}