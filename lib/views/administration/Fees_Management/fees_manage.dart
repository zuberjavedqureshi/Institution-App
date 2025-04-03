import 'package:auster_education/views/administration/Fees_Management/payment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeesManagementView extends StatefulWidget {
  final String sName;
  final double? sfees;
  final String sId;
  final String? sImage;
  final String? course;
  FeesManagementView(
      {Key? key,
      required this.course,
      required this.sId,
      required this.sName,
      this.sImage,
      this.sfees})
      : super(key: key);

  @override
  _FeesManagementViewState createState() => _FeesManagementViewState();
}

class _FeesManagementViewState extends State<FeesManagementView> {
  final db = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  bool isVisible = false;
  bool ischecked = false;
  bool isVisibleCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .40,
            decoration: BoxDecoration(
                color: Color(0xFFEDEEE9),
                border: Border.all(color: Colors.black, width: 2.5),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.deepPurpleAccent,
                        radius: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "${widget.sImage}",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 245,
                        child: Text(
                          "${widget.sName}",
                          style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Total Fees: ₹${widget.sfees}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(
                          color: Colors.green,
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => PaymentView(
                                      course: widget.course,
                                      sName: widget.sName,
                                      sID: widget.sId,
                                    )));
                      },
                      child: Text(
                        "Collect Payment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Text(
                        "View Payment Records",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Fees Records",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          buildVisibilityFeesRecord(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isVisibleCheckBox = !isVisibleCheckBox;
          });
        },
        child: Icon(Icons.share),
      ),
    );
  }

  Widget buildVisibilityFeesRecord() {
    return Expanded(
      child: Visibility(
          visible: isVisible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection("Students Fees Records")
                .doc(widget.sId)
                .collection("${widget.sName} Fees Record")
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data!.docs;
              if (!snapshot.hasData) {
                return Center(child: Text("No Record Found!"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * .85,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Visibility(
                                    visible: isVisibleCheckBox,
                                    child: Checkbox(
                                        value: ischecked,
                                        onChanged: (bool? s) {
                                          setState(() {
                                            ischecked = s!;
                                          });
                                        }),
                                  ),
                                ),
                                Text(
                                  "Amount Paid:   ${data[index].get('Paid Amount')}",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Amount In Words:   ${data[index].get('Amount In Words')}",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Date:    ${data[index].get('Payment Date')}",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Payment Mode:    ${data[index].get('Payment Method')}",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Received By:   ${data[index].get('Recevied By')}",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  });
            },
          )),
    );
  }
}
