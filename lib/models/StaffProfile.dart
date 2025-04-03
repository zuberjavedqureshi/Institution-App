import 'package:cloud_firestore/cloud_firestore.dart';

class StaffProfile {
  String? eName;
  String? eDOA;
  int? eSalary;
  String? eAddress;
  String? ePhoto;
  int? ePhoneNumber;
  String? eDegisnation;

  StaffProfile(
      {this.eName,
      this.eDOA,
      this.ePhoto,
      this.eSalary,
      this.eAddress,
      this.eDegisnation,
      this.ePhoneNumber});

  Map<String, dynamic> toJson() => {
        'Emp Name': eName,
        'Emp Salary': eSalary,
        'Emp DOA': eDOA,
        'Emp url': ePhoto,
        'Emp Address': eAddress,
        'Degisnation': eDegisnation,
        'Phone Number': ePhoneNumber,
      };
  static Future<void> updateStaff(
      {String? docId,
      String? eName,
      String? eDOA,
      int? eSalary,
      String? eAddress,
      String? ePhoto,
      int? ePhoneNumber,
      String? eDegisnation}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference _docRef = db.collection('Staff').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'Emp Name': eName,
      'Emp Salary': eSalary,
      'Emp DOA': eDOA,
      'Emp url': ePhoto,
      'Emp Address': eAddress,
      'Degisnation': eDegisnation,
      'Phone Number': ePhoneNumber,
    };

    await _docRef
        .update(data)
        .whenComplete(() => print("Staff update successfully"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteStudent({required String docId}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference documentReference = db.collection("Staff").doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Staff removed Successfully"))
        .catchError((e) => print(e));
  }
}
