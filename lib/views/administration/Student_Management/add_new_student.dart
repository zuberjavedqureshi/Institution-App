import 'dart:io';

import 'package:auster_education/models/StudentProfile.dart';
import 'package:auster_education/services/Authentication.dart';
import 'package:auster_education/views/sections/notifiers.dart';
import 'package:auster_education/views/sections/sections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_storage;

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddNewStudentView extends StatefulWidget {
  const AddNewStudentView({Key? key}) : super(key: key);

  @override
  _AddNewStudentViewState createState() => _AddNewStudentViewState();
}

class _AddNewStudentViewState extends State<AddNewStudentView> {
  final _formkey = GlobalKey<FormState>();
  StudentProfile _studentsProfile = StudentProfile();
  final db = FirebaseFirestore.instance;
  String dropDownValue = 'School Section';
  late f_storage.Reference firebaseStorage;

  DateTime _dateTime = DateTime.now();
  String? setDate;

  XFile? studentimage;
  String? imgValue;
  final ImagePicker _picker = ImagePicker();

  TextEditingController _name = TextEditingController();
  TextEditingController _course = TextEditingController();
  TextEditingController _fees = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _dob = TextEditingController();
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
          title: Text("Add Student"),
          actions: [
            IconButton(
                onPressed: () {
                  _addStudent();
                },
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
                        child: studentimage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(studentimage!.path),
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
                    controller: _name,
                    validator: (value) => NameValidator.validate(value!),
                    onSaved: (val) => _name.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Student Name*",
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
                    controller: _course,
                    validator: (value) => CourseValidator.validate(value!),
                    onSaved: (val) => _course.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Current Course*",
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
                    controller: _fees,
                    validator: (value) => FeesValidator.validate(value!),
                    onSaved: (val) => _fees.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        labelText: " Total Fees*",
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose Date of Birth* : ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      InkWell(
                        child: _buildContainer(_dob),
                        onTap: () {
                          _selectDateBirth(context);
                        },
                      ),
                    ],
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
                SizedBox(height: 20),
                Consumer(builder: (context, dropdown, child) {
                  return _showDropDownMenu();
                }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Selected: $dropDownValue",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
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
      studentimage = image;
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

  Future _selectDateBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (picked != null)
      setState(() {
        _dateTime = picked;
        _dob.text = DateFormat.yMd().format(_dateTime);
      });
  }

  _addStudent() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        firebaseStorage = f_storage.FirebaseStorage.instance
            .ref()
            .child('images/${path.basename(studentimage!.path)}');
        await firebaseStorage
            .putFile(File(studentimage!.path))
            .whenComplete(() async {
          await firebaseStorage.getDownloadURL().then((value) {
            setState(() {
              imgValue = value;
            });
          });
        });
        setState(() {
          _studentsProfile.studentImage = imgValue;
          _studentsProfile.name = _name.text.trim();
          _studentsProfile.course = _course.text.trim();
          _studentsProfile.fees = int.parse(_fees.text.trim());
          _studentsProfile.phoneNumber = int.parse(_phoneNumber.text).floor();
          _studentsProfile.section = dropDownValue;
          _studentsProfile.doa = _doa.text;
          _studentsProfile.dob = _dob.text;
          _studentsProfile.address = _address.text.trim();
        });

        db.collection('Students').add(_studentsProfile.toJson());
        Navigator.pop(context);
        final snackBar = SnackBar(content: Text("Student added successfully!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print(e);
      }
    }
  }

  Widget _showDropDownMenu() {
    final _singleNotifier = Provider.of<SingleNotifier>(context);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * .70,
      height: MediaQuery.of(context).size.width * .15,
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: DropdownButton(
          iconEnabledColor: Colors.deepPurpleAccent,
          iconSize: 30,
          dropdownColor: Colors.deepPurpleAccent,
          value: _singleNotifier.currentSection,
          onChanged: (String? value) {
            _singleNotifier.updateSection(value!);
            setState(() {
              dropDownValue = value;
            });
          },
          items: studentsSection
              .map((e) => DropdownMenuItem(
                    child: Text(
                      e,
                      style: TextStyle(
                          color: e == _singleNotifier.currentSection
                              ? Colors.red
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    value: e,
                  ))
              .toList()),
    );
  }
}
