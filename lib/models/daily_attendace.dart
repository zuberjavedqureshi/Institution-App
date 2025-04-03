class DailyAttendace {
  String? date;
  String? subject;
  String? subjectTeacher;
  bool? attendance;
  String? time;

  DailyAttendace(
      {this.date,
      this.subject,
      this.subjectTeacher,
      this.attendance,
      this.time});

  Map<String, dynamic> toJson() => {
        'Date': date,
        'Subject': subject,
        'Subject Teacher': subjectTeacher,
        'Attendance': attendance,
        'Time': time,
      };
}
