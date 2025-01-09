class Therapist {
  final int therapistId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String hiringDate;
  final int departmentId;
  final String username;

  Therapist({
    required this.therapistId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.hiringDate,
    required this.departmentId,
    required this.username,
  });

  // Factory constructor to create a Therapist from JSON data
  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      therapistId: json['therapistId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      hiringDate: json['hiringDate'],
      departmentId: json['departmentId'],
      username: json['username'],
    );
  }
}
