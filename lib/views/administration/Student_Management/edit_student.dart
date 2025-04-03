import 'package:auster_education/crud%20management/update_students.dart';
import 'package:auster_education/models/StudentProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class EditStudentView extends StatefulWidget {
  final String sImage;
  final String sId;
  final String sName;
  final String sCourse;
  final String sSection;
  final String sfees;
  final String sDoa;
  final String sDob;
  final String sPhoneNumber;
  final String sAdress;
  const EditStudentView(
      {Key? key,
      required this.sImage,
      required this.sId,
      required this.sName,
      required this.sCourse,
      required this.sSection,
      required this.sfees,
      required this.sPhoneNumber,
      required this.sDoa,
      required this.sDob,
      required this.sAdress})
      : super(key: key);

  @override
  _EditStudentViewState createState() => _EditStudentViewState();
}

class _EditStudentViewState extends State<EditStudentView> {
  final db = FirebaseFirestore.instance;
  String dropDownValue = 'School Section';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Student View"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateStudentsView(
                            sId: widget.sId,
                            sCourse: widget.sCourse,
                            sSection: widget.sSection,
                            sPhoneNumber: widget.sPhoneNumber,
                            sAdress: widget.sAdress,
                            sfees: widget.sfees,
                            sName: widget.sName,
                            sDoa: widget.sDoa,
                            sDob: widget.sDob,
                          )));
                },
                icon: Icon(
                  Icons.edit,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  deleteStudent(widget.sId);
                },
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                  size: 30,
                )),
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .30,
              color: Colors.lightBlue,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Auster Education",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        // ignore: unnecessary_null_comparison
                        child: widget.sImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  widget.sImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                      Expanded(
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "${widget.sName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .80,
                  height: MediaQuery.of(context).size.height * .15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Student Id: ${widget.sId}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Current Course: ${widget.sCourse}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Section: ${widget.sSection}"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .80,
                  height: MediaQuery.of(context).size.height * .15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Total Fees: ₹${widget.sfees}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("DOB: ${widget.sDob}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("DOA: ${widget.sDoa}"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .80,
                  height: MediaQuery.of(context).size.height * .15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Address: ${widget.sAdress}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Contact: +91 ${widget.sPhoneNumber}"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: _makePhoneCalls,
                        icon: Icon(
                          Icons.phone_forwarded_rounded,
                          size: 30,
                          color: Colors.deepPurple,
                        )),
                    IconButton(
                        onPressed: _sendSms,
                        icon: Icon(Icons.message_rounded,
                            size: 30, color: Colors.deepPurple)),
                  ],
                )
              ],
            )
          ],
        ));
  }

  deleteStudent(String id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Are you sure?",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text("Delete student permanently?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      StudentProfile.deleteStudent(docId: id);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      final snackBar = SnackBar(
                          content: Text("Student Deleted Successfully!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text("Delete")),
              ],
            ));
  }

  _makePhoneCalls() async {
    final url = "tel://${widget.sPhoneNumber}";
    launch(url);
  }

  _sendSms() async {
    final url = "sms:${widget.sPhoneNumber}";
    launch(url);
  }
}
