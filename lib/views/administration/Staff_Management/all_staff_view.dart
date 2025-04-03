import 'package:auster_education/views/administration/Staff_Management/edit_staff_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllStaffView extends StatefulWidget {
  const AllStaffView({Key? key}) : super(key: key);

  @override
  _AllStaffViewState createState() => _AllStaffViewState();
}

class _AllStaffViewState extends State<AllStaffView> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Staff"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection("Employees").snapshots(),
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
                              "section: staff sections",
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                            Text(
                              "Total Staff: ${data.length}",
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
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      buildCustomView(context, index, snapshot))
                            ],
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}

Widget buildCustomView(context, int index, AsyncSnapshot snapshot) {
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
            child: data[index].get("Emp url") != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "${data[index].get('Emp url')}",
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
              Text("${data[index].get('Emp Name')}",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              Text("${data[index].get('Degisnation')}",
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
                                builder: (context) => EditStaffView(
                                  sImage: "${data[index].get('Emp url')}",
                                  sId: "${data[index].id}",
                                  sName: "${data[index].get('Emp Name')}",
                                  sSalary: "${data[index].get('Emp Salary')}",
                                  sDegisnation:
                                      "${data[index].get('Degisnation')}",
                                  sPhoneNumber:
                                      "${data[index].get('Phone Number')}",
                                  sDoa: "${data[index].get('Emp DOA')}",
                                  sAdress: "${data[index].get('Emp Address')}",
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
