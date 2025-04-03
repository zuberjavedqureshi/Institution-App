import 'dart:io';

import 'package:auster_education/models/StaffProfile.dart';
import 'package:auster_education/services/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_storage;

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewStaffView extends StatefulWidget {
  const AddNewStaffView({Key? key}) : super(key: key);

  @override
  _AddNewStaffViewState createState() => _AddNewStaffViewState();
}

class _AddNewStaffViewState extends State<AddNewStaffView> {
  final _formkey = GlobalKey<FormState>();
  StaffProfile staffProfile = new StaffProfile();
  final db = FirebaseFirestore.instance;
  late f_storage.Reference firebaseStorage;

  DateTime _dateTime = DateTime.now();
  String? setDate;

  XFile? staffimage;
  String? imgValue;
  final ImagePicker _picker = ImagePicker();

  TextEditingController _eName = TextEditingController();
  TextEditingController _eDegisnation = TextEditingController();
  TextEditingController _eSalary = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _doa = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Staff"),
          actions: [
            IconButton(
                onPressed: _addStaff,
                icon: Icon(
                  Icons.done_rounded,
                  size: 30,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: selectImage,
                      child: CircleAvatar(
                        radius: 50,
                        child: staffimage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(staffimage!.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.red,
                    controller: _eName,
                    validator: (value) => NameValidator.validate(value!),
                    onSaved: (val) => _eName.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Staff Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.deepPurpleAccent,
                        ),
                        labelStyle: TextStyle(color: Colors.red),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.red,
                    controller: _eDegisnation,
                    validator: (value) => CourseValidator.validate(value!),
                    onSaved: (val) => _eDegisnation.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Current Degisnation*",
                        prefixIcon: Icon(
                          Icons.book,
                          color: Colors.deepPurpleAccent,
                        ),
                        labelStyle: TextStyle(color: Colors.red),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.number,
                    controller: _eSalary,
                    validator: (value) => FeesValidator.validate(value!),
                    onSaved: (val) => _eSalary.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Total Salary*",
                        prefixIcon: Icon(
                          Icons.monetization_on_rounded,
                          color: Colors.deepPurpleAccent,
                        ),
                        labelStyle: TextStyle(color: Colors.red),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumber,
                    validator: (value) => validateMobile(value!),
                    onSaved: (val) => _phoneNumber.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Phone Number*",
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.deepPurpleAccent,
                        ),
                        labelStyle: TextStyle(color: Colors.red),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose Date of Admission* : ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      InkWell(
                        child: _buildContainer(_doa),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.deepPurple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.red,
                    controller: _address,
                    validator: (value) => AddressValidator.validate(value!),
                    onSaved: (val) => _address.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Address*",
                        prefixIcon: Icon(
                          Icons.home,
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
        ),
      ),
    );
  }

  selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      staffimage = image;
    });
  }

  Widget _buildContainer(TextEditingController doa) {
    return Container(
      width: MediaQuery.of(context).size.width * .40,
      height: MediaQuery.of(context).size.width * .12,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
      ),
      child: TextFormField(
        controller: doa,
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

  _addStaff() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        firebaseStorage = f_storage.FirebaseStorage.instance
            .ref()
            .child('StaffImages/${path.basename(staffimage!.path)}');
        await firebaseStorage
            .putFile(File(staffimage!.path))
            .whenComplete(() async {
          await firebaseStorage.getDownloadURL().then((value) {
            setState(() {
              imgValue = value;
            });
          });
        });
        setState(() {
          staffProfile.ePhoto = imgValue;
          staffProfile.eName = _eName.text.trim();
          staffProfile.eDegisnation = _eDegisnation.text.trim();
          staffProfile.eSalary = int.parse(_eSalary.text.trim());
          staffProfile.ePhoneNumber = int.parse(_phoneNumber.text).floor();

          staffProfile.eDOA = _doa.text;

          staffProfile.eAddress = _address.text.trim();
        });

        db.collection('Staff').add(staffProfile.toJson());
        Navigator.pop(context);
        final snackBar = SnackBar(content: Text("Staff added successfully!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print(e);
      }
    }
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
        _doa.text = DateFormat.yMd().format(_dateTime);
      });
  }
}
