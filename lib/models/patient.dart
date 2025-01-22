
import 'package:flareline_crm/models/session.dart';

class Patient {
  int id;
  String firstName;
  String lastName;
  int therapistId;
  String therapistName;
  int departmentId;
  int paymentMethodId;
  int insuranceId;
  String insuranceName;
  int sessionPrice;
  int numberOfTotalSessions;
  String notes;
  String createdDate;
  int numberOfPreviousSessions;
  double balance;
  List<Session> previousSessions;

  // Convert a patient from JSON

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.therapistId,
    required this.therapistName,
    required this.departmentId,
    required this.paymentMethodId,
    required this.insuranceId,
    required this.insuranceName,
    required this.sessionPrice,
    required this.numberOfTotalSessions,
    required this.notes,
    required this.createdDate,
    required this.numberOfPreviousSessions,
    required this.previousSessions,
    required this.balance,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    var sessionsList = json['takenSessions'] as List? ?? [];
    List<Session> sessions =
        sessionsList.map((i) => Session.fromJson(i)).toList();

    return Patient(
      id: json['patientId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      therapistId: json['therapistId'] ?? 0,
      therapistName: json['therapistName'] ?? '',
      departmentId: json['departmentId'] ?? 1,
      paymentMethodId: json['paymentMethodId'] ?? 0,
      insuranceId: json['insuranceId'] ?? 0,
      insuranceName: json['insuranceName'] ?? '',
      sessionPrice: json['sessionPrice'] ?? 0.0,
      numberOfTotalSessions: json['numberOfSessions'] ?? 0,
      notes: json['notes'] ?? '',
      createdDate: json['createdDate'] ?? '',
      numberOfPreviousSessions: json['numberOfPreviousSessions'] ?? 0,
      previousSessions: sessions,
      balance: json['balance']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'Patient { id: $id, name: $firstName $lastName, section: $departmentId, sessions: $numberOfTotalSessions, balance: $balance }';
  }
}
