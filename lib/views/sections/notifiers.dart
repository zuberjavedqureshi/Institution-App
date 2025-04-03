import 'package:auster_education/views/sections/sections.dart';
import 'package:flutter/cupertino.dart';

class SingleNotifier extends ChangeNotifier {
  String _currentSection = studentsSection[0];
  SingleNotifier();

  String get currentSection => _currentSection;

  updateSection(String value) {
    if (value != _currentSection) {
      _currentSection = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SinglePaymentNotifier extends ChangeNotifier {
  String _currentMethod = feesMethods[0];
  SinglePaymentNotifier();

  String get currentMethod => _currentMethod;

  updateMethod(String value) {
    if (value != _currentMethod) {
      _currentMethod = value;
      notifyListeners();
    }
  }
}

class AttendanceNotifier extends ChangeNotifier {
  String _present = attendance[0];
  String _absent = attendance[1];
  AttendanceNotifier();

  String get isPresent => _present;
  String get isAbsent => _absent;

  updateAttendanceToPresent(String value) {
    if (value != _present) {
      _present = value;
      notifyListeners();
    }
  }

  updateAttendanceToAbsent(String value) {
    if (value != _present) {
      _present = value;
      notifyListeners();
    }
  }
}
