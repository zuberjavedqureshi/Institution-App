import 'package:auster_education/services/Authentication.dart';
import 'package:auster_education/views/administration/Fees_Management/payment_summary.dart';
import 'package:auster_education/views/sections/notifiers.dart';
import 'package:auster_education/views/sections/sections.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PaymentView extends StatefulWidget {
  final String sName;
  final String sID;
  final String? course;
  const PaymentView(
      {Key? key, required this.sName, required this.sID, this.course})
      : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _feesPaid = TextEditingController();
  TextEditingController _amtInWords = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _receiverName = TextEditingController();

  String? paymentMethod = 'Cash';
  DateTime _dateTime = DateTime.now();
  String? setDate;

  double? amount;
  String? amtInWords;
  String? receiverName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment View"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: _paymentDone,
              icon: Icon(Icons.done),
              iconSize: 25,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                          "Payment Received From: (${widget.sName.toUpperCase()})"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.red,
                      controller: _feesPaid,
                      validator: (value) => FeesValidator.validate(value!),
                      onSaved: (val) => _feesPaid.text = val!,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2)),
                          labelText: " Amount*",
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            color: Colors.deepPurpleAccent,
                          ),
                          labelStyle: TextStyle(color: Colors.red),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.red,
                      controller: _amtInWords,
                      validator: (value) => AmountValidator.validate(value!),
                      onSaved: (val) => _amtInWords.text = val!,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2)),
                          labelText: " Amount In Words*",
                          prefixIcon: Icon(
                            Icons.work,
                            color: Colors.deepPurpleAccent,
                          ),
                          labelStyle: TextStyle(color: Colors.red),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Select Date:*"),
                          SizedBox(
                            width: 15.0,
                          ),
                          _buildContainer(),
                        ],
                      ),
                      onTap: () {
                        _selectDate(context);
                      }),
                  Consumer(builder: (context, dropdown, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Select Payment Mode:*"),
                        _showPaymentDropDownMenu(),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.red,
                      controller: _receiverName,
                      validator: (value) => NameValidator.validate(value!),
                      onSaved: (val) => _receiverName.text = val!,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2)),
                          labelText: " Your Name*",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.deepPurpleAccent,
                          ),
                          labelStyle: TextStyle(color: Colors.red),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentDone() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSummaryView(
                  paymentMode: paymentMethod,
                  course: widget.course,
                  date: setDate,
                  sName: widget.sName,
                  sID: widget.sID,
                  totalAmt: double.parse(_feesPaid.text.trim()),
                  amtInWords: _amtInWords.text.trim(),
                  receiverName: _receiverName.text.trim())));
    }
  }

  Widget _showPaymentDropDownMenu() {
    final _singlepaymentNotifier = Provider.of<SinglePaymentNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButton(
          iconEnabledColor: Colors.deepPurpleAccent,
          iconSize: 30,
          dropdownColor: Colors.deepPurpleAccent,
          value: _singlepaymentNotifier.currentMethod,
          onChanged: (String? value) {
            _singlepaymentNotifier.updateMethod(value!);
            setState(() {
              paymentMethod = value;
            });
          },
          items: feesMethods
              .map((e) => DropdownMenuItem(
                    child: Text(
                      e,
                      style: TextStyle(
                          color: e == _singlepaymentNotifier.currentMethod
                              ? Colors.red
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    value: e,
                  ))
              .toList()),
    );
  }

  Widget _buildContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * .40,
      height: MediaQuery.of(context).size.width * .12,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
      ),
      child: TextFormField(
        controller: _date,
        style: TextStyle(fontSize: 25, color: Colors.white),
        enabled: false,
        textAlign: TextAlign.center,
        onSaved: (val) => setDate = val!,
        decoration: InputDecoration(
          hintText: 'Calender',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
            height: 1,
          ),
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.only(top: 0.0, bottom: 10),
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (picked != null)
      setState(() {
        _dateTime = picked;
        _date.text = DateFormat.yMd().format(_dateTime);
      });
  }
}
