import 'package:auster_education/services/Authentication.dart';
import 'package:auster_education/views/authentications/sign_up_view.dart';
import 'package:auster_education/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: Align(
            //     child: SvgPicture.asset(
            //       "images/signIn.svg",
            //       height: 250,
            //     ),
            //     alignment: Alignment.topCenter,
            //   ),
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 20, color: Colors.green[500]),
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  contentPadding: EdgeInsets.all(5),
                                  suffixIcon: Icon(
                                    Icons.email_rounded,
                                    color: Colors.white,
                                  )),
                              controller: email,
                              validator: (value) =>
                                  EmailValidator.validate(value!),
                              onSaved: (val) => email.text = val!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 20, color: Colors.green[500]),
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  contentPadding: EdgeInsets.all(5),
                                  suffixIcon: Icon(
                                    Icons.vpn_key_rounded,
                                    color: Colors.white,
                                  )),
                              controller: password,
                              validator: (value) =>
                                  PasswordValidator.validate(value!),
                              onSaved: (val) => password.text = val!,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: signInUser,
                      child: Text("LogIn"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[600],
                        fixedSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I'm new user",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpView()));
                            },
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signInUser() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
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
