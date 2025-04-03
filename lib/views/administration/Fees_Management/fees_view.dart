import 'package:auster_education/views/administration/Fees_Management/fees_manage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeesView extends StatefulWidget {
  const FeesView({Key? key}) : super(key: key);

  @override
  _FeesViewState createState() => _FeesViewState();
}

class _FeesViewState extends State<FeesView> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fees Management"),
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
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return _buildFeesView(context, index, snapshot);
                    });
              }
            }));
  }
}

Widget _buildFeesView(context, int index, AsyncSnapshot snapshot) {
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
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                child: Text("${data[index].get('Name')}",
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Fees: ₹${data[index].get('Fees')}",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15))
            ],
          ),
          Spacer(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        iconSize: 20,
                        color: Colors.deepPurple,
                        onPressed: () async {
                          final url =
                              "tel://${data[index].get('Phone Number')}";
                          launch(url);
                        },
                        icon: Icon(Icons.phone)),
                    InkWell(
                      child: Text(
                        "Manage",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeesManagementView(
                                      course: "${data[index].get('Course')}",
                                      sId: "${data[index].id}",
                                      sfees: double.parse(
                                          "${data[index].get('Fees')}"),
                                      sImage: "${data[index].get('url')}",
                                      sName: "${data[index].get('Name')}",
                                    )));
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
