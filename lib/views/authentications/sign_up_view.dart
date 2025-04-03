import 'package:auster_education/services/Authentication.dart';
import 'package:auster_education/views/authentications/sign_in_view.dart';
import 'package:auster_education/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  User? user;

  final _auth = FirebaseAuth.instance;
  AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: Align(
              //     child: SvgPicture.asset(
              //       "images/login.svg",
              //       height: 250,
              //     ),
              //     alignment: Alignment.topCenter,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                )),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[500]),
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.all(5),
                              suffixIcon: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                              )),
                          controller: name,
                          validator: (value) => NameValidator.validate(value!),
                          onSaved: (val) => name.text = (val!),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[500]),
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.all(5),
                              suffixIcon: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                              )),
                          controller: email,
                          validator: (value) => EmailValidator.validate(value!),
                          onSaved: (val) => email.text = (val!),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[500]),
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.all(5),
                              suffixIcon: Icon(
                                Icons.vpn_key_rounded,
                                color: Colors.white,
                              )),
                          controller: password,
                          validator: (value) =>
                              PasswordValidator.validate(value!),
                          onSaved: (val) => password.text = (val!),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                  child: ElevatedButton(
                onPressed: signUpUser,
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600],
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I'm already a User (:",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInView()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUpUser() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      try {
        await _authServices.createUserWithEmailandPassword(
            name.text, email.text, password.text);
        await _auth.currentUser!.updateDisplayName(name.text);
        User? user = _auth.currentUser;
        await user?.reload();
        user = _auth.currentUser;
        if (user != null) {
          setState(() {
            this.user = user;
          });
        }
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        errorMsg(e.message);
      }
    }
  }

  errorMsg(errormsg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Error",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              content: Text(errormsg,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK",
                      style: TextStyle(
                          color: Colors.red[500],
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ));
  }
}
