import 'package:auster_education/services/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                child: CircleAvatar(
                    maxRadius: 50.0, child: AuthServices().getProfileImage()),
              ),
              Container(
                  child: FutureBuilder(
                future: AuthServices().getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return displayUserName(context, snapshot);
                  }
                },
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email: ${_auth.currentUser!.email} ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: OutlinedButton(
              //     style: OutlinedButton.styleFrom(
              //         fixedSize: Size(100, 30),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //         side: BorderSide(color: Colors.red),
              //         backgroundColor: Colors.red),
              //     onPressed: () {
              //       Navigator.pushReplacement(context,
              //           MaterialPageRoute(builder: (context) => SignInView()));
              //     },
              //     child: Text(
              //       "Sign Out",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayUserName(context, snapshot) {
    final _authData = snapshot.data;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Name: ${_authData.displayName ?? 'Anonumous'}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.green[500],
          )),
    );
  }

  signOut() async {
    await _auth.signOut();
  }
}
