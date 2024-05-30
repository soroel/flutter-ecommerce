class PaymentDetails {
  final String number;
  final String trnxId;
  final double amount;

  PaymentDetails({
    required this.number,
    required this.trnxId,
    required this.amount
  });

  Map<String, dynamic> toJson() => {
    'number': number,
    'trnx_id': trnxId,
    'amount': amount,
  };
}
