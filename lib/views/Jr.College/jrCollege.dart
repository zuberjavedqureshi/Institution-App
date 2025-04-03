import 'package:auster_education/views/Jr.College/jrCollege_view_all.dart';
import 'package:flutter/material.dart';

class JRCollegeSectionView extends StatefulWidget {
  const JRCollegeSectionView({Key? key}) : super(key: key);

  @override
  JRCollegeSectionViewState createState() => JRCollegeSectionViewState();
}

class JRCollegeSectionViewState extends State<JRCollegeSectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joniour College Section"),
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
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "JrCollege Section Management",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
                                            JRCollegeAllStudentsView()));
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
        ],
      ),
    );
  }
}
