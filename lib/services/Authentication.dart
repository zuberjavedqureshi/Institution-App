//import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _auth.authStateChanges().map(
        (User? user) => user!.uid,
      );

  //Get UID
  String getCurrentUID() {
    return _auth.currentUser!.uid;
  }

  //Get User
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  getProfileImage() {
    if (_auth.currentUser!.photoURL != null) {
      return Image.network(
        "${_auth.currentUser!.photoURL}",
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Icon(
        Icons.account_circle_rounded,
        size: 50,
      );
    }
  }

  Future<String> createUserWithEmailandPassword(
    String? name,
    String email,
    String password,
  ) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await updateUserName(name, authResult.user);
    return authResult.user!.uid;
  }

  updateUserName(String? name, User? currentUser) async {
    currentUser!.displayName;
    currentUser.photoURL;
  }

  Future<String> signInWithEmailandPassword(
      String email, String password) async {
    return (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user!
        .uid;
  }

  Future signInAnonymously() {
    return _auth.signInAnonymously();
  }

  Future signOut() {
    return _auth.signOut();
  }
}

class NameValidator {
  static validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be atleast 2 character long";
    }
    if (value.length > 30) {
      return "Name must be less than 30 character long";
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}

class FeesValidator {
  static String? validate(String value) {
    if (value.length == 0) {
      return 'Please enter total fees amount';
    } else if (value.length > 100000) {
      return 'Please enter valid fees amount';
    }
    return null;
  }
}

String? validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

class AddressValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "address can't be empty";
    }
    return null;
  }
}

class CourseValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "course can't be empty";
    }
    return null;
  }
}

class AmountValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return "amount can't be empty";
    }
    return null;
  }
}
