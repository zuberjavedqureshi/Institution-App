import 'package:auster_education/models/StudentProfile.dart';
import 'package:auster_education/services/Authentication.dart';
import 'package:auster_education/views/administration/Student_Management/edit_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JRCollegeAllStudentsView extends StatefulWidget {
  const JRCollegeAllStudentsView({Key? key}) : super(key: key);

  @override
  _JRCollegeAllStudentsViewState createState() =>
      _JRCollegeAllStudentsViewState();
}

class _JRCollegeAllStudentsViewState extends State<JRCollegeAllStudentsView> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  //StudentProfile _studentProfile = StudentProfile();
  TextEditingController _name = TextEditingController();
  TextEditingController _course = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  String dropDownValue = "School Section";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Students"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_rounded),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection("Students")
              .where('Section', isEqualTo: 'Jr.College')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading...."));
            }
            if (!snapshot.hasData) {
              return Center(child: Text("Something went wrong."));
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green, width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "section: Jr.College Section",
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                            Text(
                              "Total Students: ${data.length}",
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.yellow[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            margin: const EdgeInsets.all(4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  child: data[index].get("url") != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            "${data[index].get('url')}",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          width: 70,
                                          height: 70,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                ),
                                title: Text("${data[index].get('Name')}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.redAccent)),
                                trailing: IconButton(
                                    onPressed: () {
                                      print(
                                          "You tap:${data[index].get('Name')}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditStudentView(
                                              sImage:
                                                  "${data[index].get('url')}",
                                              sId: "${data[index].id}",
                                              sName:
                                                  "${data[index].get('Name')}",
                                              sCourse:
                                                  "${data[index].get('Course')}",
                                              sSection:
                                                  "${data[index].get('Section')}",
                                              sfees:
                                                  "${data[index].get('Fees')}",
                                              sPhoneNumber:
                                                  "${data[index].get('Phone Number')}",
                                              sDoa:
                                                  "${data[index].get('Date of Admission')}",
                                              sDob:
                                                  "${data[index].get('Date of Birth')}",
                                              sAdress:
                                                  "${data[index].get('Address')}",
                                            ),
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.visibility_rounded,
                                      size: 20,
                                      color: Colors.blueAccent,
                                    )),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }

  editStudents(String docId) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "What do you want to do?",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.cancel_rounded)),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  updateStudents(docId);
                },
                icon: Icon(Icons.edit),
                label: Text("UPDATE"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                  fixedSize: Size(105, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  deleteStudent(docId);
                },
                icon: Icon(Icons.delete_outline_rounded),
                label: Text("DELETE"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red,
                  fixedSize: Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.all(15.0),
      ),
    );
  }

  updateStudents(String id) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Update Student"),
        children: [
          SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _name,
                        validator: (value) => NameValidator.validate(value!),
                        onSaved: (val) => _name.text = val!,
                        decoration: InputDecoration(
                          labelText: " Student Name",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _course,
                        validator: (value) => NameValidator.validate(value!),
                        onSaved: (val) => _course.text = val!,
                        decoration: InputDecoration(
                          labelText: " Current Course",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _phoneNumber,
                        validator: (value) => validateMobile(value!),
                        onSaved: (val) => _phoneNumber.text = val!,
                        decoration: InputDecoration(
                          labelText: " Phone Number",
                        ),
                      ),
                    ),
                    DropdownButton(
                      value: dropDownValue,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 20,
                      elevation: 15,
                      style: TextStyle(color: Colors.red),
                      underline: Container(
                        height: 2,
                        color: Colors.red,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropDownValue = value!;
                        });
                      },
                      items: ["School Section", "D.Pharmacy", "D.M.L.T"]
                          .map((String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          StudentProfile.updateStudent(
                              docId: id,
                              name: _name.text.trim(),
                              course: _course.text.trim(),
                              phoneNumber: int.parse(_phoneNumber.text).floor(),
                              section: dropDownValue);
                          Navigator.pop(context);
                        },
                        child: Text("Update Details"))
                  ],
                )),
          )
        ],
      ),
    );
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      StudentProfile.deleteStudent(docId: id);
                    },
                    child: Text("Delete")),
              ],
            ));
  }
}
