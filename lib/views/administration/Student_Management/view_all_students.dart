import 'package:auster_education/views/administration/Student_Management/edit_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllStudents extends StatefulWidget {
  const ViewAllStudents({Key? key}) : super(key: key);

  @override
  _ViewAllStudentsState createState() => _ViewAllStudentsState();
}

class _ViewAllStudentsState extends State<ViewAllStudents> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Students"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  //showSearch(context: context, delegate: SearchBar());
                },
                icon: Icon(Icons.search_rounded)),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection("Students").snapshots(),
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
                              "section: All sections",
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
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return _buildCustomView(context, index, snapshot);
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget _buildCustomView(context, int index, AsyncSnapshot snapshot) {
    var data = snapshot.data.docs;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .13,
        decoration: BoxDecoration(
            color: Colors.white12,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepPurpleAccent,
              child: data[index].get("url") != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
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
                          borderRadius: BorderRadius.circular(50)),
                      width: 70,
                      height: 70,
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: Text("${data[index].get('Name')}",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("${data[index].get('Course')}",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          iconSize: 25,
                          color: Colors.deepPurple,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditStudentView(
                                    sId: "${data[index].id}",
                                    sImage: "${data[index].get('url')}",
                                    sName: "${data[index].get('Name')}",
                                    sCourse: "${data[index].get('Course')}",
                                    sSection: "${data[index].get('Section')}",
                                    sPhoneNumber:
                                        "${data[index].get('Phone Number')}",
                                    sAdress: "${data[index].get('Address')}",
                                    sfees: "${data[index].get('Fees')}",
                                    sDoa:
                                        "${data[index].get('Date of Admission')}",
                                    sDob: "${data[index].get('Date of Birth')}",
                                  ),
                                ));
                          },
                          icon: Icon(Icons.visibility_rounded)),
                      Text("view",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
