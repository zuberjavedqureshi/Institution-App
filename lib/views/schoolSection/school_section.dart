import 'package:auster_education/views/schoolSection/all_students_view.dart';
import 'package:flutter/material.dart';

class SchoolSectionView extends StatefulWidget {
  const SchoolSectionView({Key? key}) : super(key: key);

  @override
  _SchoolSectionViewState createState() => _SchoolSectionViewState();
}

class _SchoolSectionViewState extends State<SchoolSectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("School Section"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .30,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black, width: 2)),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Auster Education",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "School Section Management",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              )),
            ),
          ),

          Column(
            children: [
              SizedBox(
                height: 140,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.height * .20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.school,
                              color: Colors.deepPurpleAccent,
                              size: 30,
                            ),
                            Text(
                              "Students List",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllStudentsView()));
                              },
                              child: Text("view"),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0, backgroundColor: Colors.deepPurpleAccent,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                fixedSize: Size(100, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.height * .20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.deepPurpleAccent,
                              size: 30,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Daily Attendance",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SchoolSectionAttendaceView()));
                                final snackBar = SnackBar(
                                  content: Text(
                                      "This feature in not available yet!"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: Text("Take"),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0, backgroundColor: Colors.deepPurpleAccent,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                fixedSize: Size(100, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.height * .20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.deepPurpleAccent,
                              size: 30,
                            ),
                            Text(
                              "Fees",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Manage"),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0, backgroundColor: Colors.deepPurpleAccent,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                fixedSize: Size(100, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.height * .20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_view_week_rounded,
                              color: Colors.deepPurpleAccent,
                              size: 30,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Monthly Attendance",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final snackBar = SnackBar(
                                  content: Text(
                                      "This feature in not available yet!"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: Text("view"),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0, backgroundColor: Colors.deepPurpleAccent,
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                fixedSize: Size(100, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * .70,
          //         height: 40.0,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(25)),
          //           border: Border.all(color: Colors.red, width: 2),
          //         ),
          //         child: GestureDetector(
          //           child: Center(child: Text("View All Students")),
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => AllStudentsView()));
          //           },
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 20,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Container(
          //         width: MediaQuery.of(context).size.width * .70,
          //         height: 40.0,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(25)),
          //           border: Border.all(color: Colors.red, width: 2),
          //         ),
          //         child: GestureDetector(
          //           child: Center(child: Text("Attendance Records")),
          //           onTap: () {
          //             // Navigator.push(
          //             //     context,
          //             //     MaterialPageRoute(
          //             //         builder: (context) =>
          //             //             SchoolSectionAttendaceView()));
          //             final snackbar =
          //                 SnackBar(content: Text("We are Working on it !!"));
          //             ScaffoldMessenger.of(context).showSnackBar(snackbar);
          //           },
          //         ),
          //       ),
          //     ),
          //     // ElevatedButton(
          //     //     onPressed: () {
          //     //       Navigator.pushReplacement(context,
          //     //           MaterialPageRoute(builder: (context) => HomePage()));
          //     //     },
          //     //     child: Text("Home Page"))
          //   ],
          // ),
        ],
      ),
    );
  }
}
