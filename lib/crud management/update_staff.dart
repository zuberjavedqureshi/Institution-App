import 'package:auster_education/models/StudentProfile.dart';
import 'package:auster_education/services/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStaffView extends StatefulWidget {
  final String sImage;
  final String sId;
  final String sName;
  final String sDegisnation;
  final String sSalary;
  final String sDoa;
  final String sPhoneNumber;
  final String sAdress;
  const UpdateStaffView(
      {Key? key,
      required this.sSalary,
      required this.sDegisnation,
      required this.sImage,
      required this.sId,
      required this.sName,
      required this.sPhoneNumber,
      required this.sDoa,
      required this.sAdress})
      : super(key: key);

  @override
  _UpdateStaffViewState createState() => _UpdateStaffViewState();
}

class _UpdateStaffViewState extends State<UpdateStaffView> {
  final db = FirebaseFirestore.instance;
  String dropDownValue = 'School Section';

  TextEditingController _name = TextEditingController();
  TextEditingController _course = TextEditingController();
  TextEditingController _fees = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Students Details"),
          actions: [
            IconButton(
                onPressed: () async {
                  StudentProfile.updateStudent(
                    docId: widget.sId,
                    name: _name.text.trim(),
                    course: _course.text.trim(),
                    phoneNumber: int.parse(_phoneNumber.text).floor(),
                    address: _address.text.trim(),
                  );
                  Navigator.pop(context);
                },
                icon: Icon(Icons.done)),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                      "Update details for- (${widget.sName.toUpperCase()})"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: _name,
                    validator: (value) => NameValidator.validate(value!),
                    onSaved: (val) => _name.text = val!,
                    decoration: InputDecoration(
                      hintText: "${widget.sName}",
                      labelText: "New Name",
                      prefixIcon: Icon(Icons.person),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: _course,
                    validator: (value) => NameValidator.validate(value!),
                    onSaved: (val) => _course.text = val!,
                    decoration: InputDecoration(
                      hintText: "${widget.sDegisnation}",
                      labelText: "New Degisnation",
                      prefixIcon: Icon(Icons.book),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: _fees,
                    validator: (value) => FeesValidator.validate(value!),
                    onSaved: (val) => _fees.text = val!,
                    decoration: InputDecoration(
                      hintText: "${widget.sSalary}",
                      labelText: "New Fees",
                      prefixIcon: Icon(Icons.monetization_on),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: _phoneNumber,
                    validator: (value) => validateMobile(value!),
                    onSaved: (val) => _phoneNumber.text = val!,
                    decoration: InputDecoration(
                      hintText: "${widget.sPhoneNumber}",
                      labelText: "New Mobile Number",
                      prefixIcon: Icon(Icons.phone),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: _address,
                    validator: (value) => NameValidator.validate(value!),
                    onSaved: (val) => _address.text = val!,
                    decoration: InputDecoration(
                      hintText: "${widget.sAdress}",
                      labelText: "New Address",
                      prefixIcon: Icon(Icons.person),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .80,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.info_outline_rounded),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "You can't update section/DOA/DOB!",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
