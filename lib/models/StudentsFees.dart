class FeesReceipt {
  String? standard;
  String? sId;
  String? sName;
  String? date;
  double? totalAmtReceived;
  String? paymentMethod;
  String? whoReceived;
  String? amtInWords;

  FeesReceipt(
      {this.sId,
      this.standard,
      this.sName,
      this.date,
      this.totalAmtReceived,
      this.amtInWords,
      this.paymentMethod,
      this.whoReceived});

  Map<String, dynamic> toJson() => {
        'Student Name': sName,
        'Standard/Course': standard,
        'Payment Date': date,
        'Paid Amount': totalAmtReceived,
        'Amount In Words': amtInWords,
        'Payment Method': paymentMethod,
        'Recevied By': whoReceived
      };
}
