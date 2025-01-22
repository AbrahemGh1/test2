class Session {
  String sessionId;
  String insuranceCompany;
  List<String> paymentMethods;
  double sessionPrice;
  DateTime sessionDate;
  String sessionNote;
  String therapistName;

  Session({
    required this.sessionId,
    required this.insuranceCompany,
    required this.paymentMethods,
    required this.sessionPrice,
    required this.sessionDate,
    required this.sessionNote,
    required this.therapistName,
  });

  // Convert a session from JSON
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      insuranceCompany: json['insuranceCompany'],
      paymentMethods: List<String>.from(json['paymentMethods']),
      sessionPrice: json['sessionPrice'].toDouble(),
      sessionDate: DateTime.parse(json['sessionDate']),
      sessionNote: json['sessionNote'],
      therapistName: json['therapistName'],
    );
  }

  @override
  String toString() {
    return 'Session { sessionId: $sessionId, insuranceCompany: $insuranceCompany, sessionPrice: $sessionPrice, sessionDate: $sessionDate, therapistName: $therapistName }';
  }
}
