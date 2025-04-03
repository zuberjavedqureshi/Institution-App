import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfile {
  String? studentImage;
  String? name;
  String? course;
  String? section;
  int? phoneNumber;
  int? fees;
  String? doa;
  String? dob;
  String? address;

  StudentProfile(
      {this.name,
      this.course,
      this.section,
      this.phoneNumber,
      this.fees,
      this.studentImage});

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Course': course,
        'Section': section,
        'Phone Number': phoneNumber,
        'Fees': fees,
        'Date of Admission': doa,
        'Date of Birth': dob,
        'Address': address,
        'url': studentImage,
      };

  StudentProfile.fromSnapShot(DocumentSnapshot snapshot)
      : name = snapshot.get('Name'),
        course = snapshot.get('Course'),
        section = snapshot.get('Section'),
        phoneNumber = snapshot.get('Phone Number'),
        fees = snapshot.get('Fees');

  static Future<void> updateStudent(
      {String? docId,
      String? name,
      String? course,
      String? section,
      int? phoneNumber,
      int? fees,
      String? doa,
      String? dob,
      String? address}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference _docRef = db.collection('Students').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "Name": name,
      "Course": course,
      "Section": section,
      "Phone Number": phoneNumber,
      "Fees": fees,
      'Date of Admission': doa,
      'Date of Birth': dob,
      'Address': address,
    };

    await _docRef
        .update(data)
        .whenComplete(() => print("Student update successfully"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteStudent({required String docId}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference documentReference = db.collection("Students").doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Student removed Successfully"))
        .catchError((e) => print(e));
  }
}
