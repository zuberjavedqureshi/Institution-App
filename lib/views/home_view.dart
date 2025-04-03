import 'package:auster_education/services/Authentication.dart';
import 'package:auster_education/views/AboutUs/ContactInfo/contact_Info_view.dart';
import 'package:auster_education/views/AboutUs/Gallery/my_gallery_view.dart';
import 'package:auster_education/views/administration/Fees_Management/fees_view.dart';
import 'package:auster_education/views/administration/Staff_Management/staff_section.dart';
import 'package:auster_education/views/administration/Student_Management/add_new_student.dart';
import 'package:auster_education/views/administration/Student_Management/view_all_students.dart';
import 'package:auster_education/views/authentications/profile_view.dart';
import 'package:auster_education/views/authentications/sign_in_view.dart';
import 'package:auster_education/views/sections/sections.dart';
import 'package:auster_education/views/sections/sections_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final date = DateTime.now();
  final time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/logo-02-removebg.png',
                width: 40,
                height: 40,
              ),
              Text(
                "Auster Education",
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
        ),
        elevation: 0.0,
        actions: [
          //IconButton(onPressed: addStudents, icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                _showLogOutDialog(context);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(width: 2),
              ),
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: Center(
                  child: Text(
                "Dashboard",
                style: TextStyle(color: Colors.white, fontSize: 25),
              )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Welcome, ${_auth.currentUser!.displayName} Sir!"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${time.format(context)}"),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Administration Setup",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(18, 1, 18, 5),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: administrationSetUp.length,
                itemBuilder: (context, index) {
                  return buildAdminGridView(context, index);
                }),
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "About Us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(18, 5, 18, 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 2,
                ),
                itemCount: aboutUs.length,
                itemBuilder: (context, index) {
                  return buildAboutGridView(context, index);
                }),
          ),
          Center(child: Text("All Rights Resereved - 2019-21"))
        ],
      ),
      drawer: myDrawer(),
    );
  }

  buildAdminGridView(BuildContext context, int index) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(width: 2),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            adminIconList[index],
            SizedBox(
              height: 5,
            ),
            Text(
              "${administrationSetUp[index]}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onTap: () {
        switch (index) {
          case 0:
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SectionListView()));
            }
            break;
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewStudentView()),
              );
            }
            break;
          case 2:
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewAllStudents()));
            }
            break;
          case 3:
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FeesView()));
            }
            break;
          case 4:
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StaffsectionView()));
            }
            break;
          default:
        }
      },
    );
  }

  buildAboutGridView(BuildContext context, int index) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(width: 2),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            aboutIconList[index],
            SizedBox(
              height: 5,
            ),
            Text(
              "${aboutUs[index]}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactInfoView()));
            break;
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GalleryView()));
            break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GalleryView()));

            break;
          default:
        }
        print("You tap: ${aboutUs[index]}");
      },
    );
  }

  Widget myDrawer() {
    return Drawer(
        child: ListView(
      children: [
        Image(image: AssetImage('images/logo-02.jpg')),
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Auster Education",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.grey,
            size: 30.0,
          ),
          title: Text(
            "Home",
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.menu_book_rounded,
            color: Colors.grey,
            size: 25.0,
          ),
          title: Text(
            "sections",
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.grey,
            size: 30.0,
          ),
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileView()));
          },
        ),
        Divider(),
      ],
    ));
  }

  _showLogOutDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Log Out"),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    logOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInView()));
                  },
                  child: Text("Log Out"))
            ],
          ));
  logOut() {
    return AuthServices().signOut();
  }
}
