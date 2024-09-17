class Student {
  String id;
  String firstname;
  String lastname;
  String course;
  String year;
  bool enrolled;

  Student({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      course: json['course'],
      year: json['year'],
      enrolled: json['enrolled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstname': firstname,
      'lastname': lastname,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    };
  }
}
