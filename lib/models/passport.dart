class Passport {
  final int? id;
  final String passportNumber;
  final String fullName;
  final String nationality;
  final String? dateOfBirth; 
  final String? gender; 
  final String issueDate;
  final String expiryDate;
  final String photoPath;

  Passport({
    this.id,
    required this.passportNumber,
    required this.fullName,
    required this.nationality,
    this.dateOfBirth, 
    this.gender, 
    required this.issueDate,
    required this.expiryDate,
    required this.photoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passportNumber': passportNumber,
      'fullName': fullName,
      'nationality': nationality,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'photoPath': photoPath,
    };
  }

  factory Passport.fromMap(Map<String, dynamic> map) {
    return Passport(
      id: map['id'],
      passportNumber: map['passportNumber'],
      fullName: map['fullName'],
      nationality: map['nationality'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      issueDate: map['issueDate'],
      expiryDate: map['expiryDate'],
      photoPath: map['photoPath'] ?? '',
    );
  }
}
