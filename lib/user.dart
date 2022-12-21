class User {
  final int id;
  final String turkishId;
  final String name;
  final String surname;
  final String password;
  final DateTime dateOfBirth;
  final bool maritalStatus;
  final List<String> interests;
  final bool hasDriverLicense;

  User({
    required this.id,
    required this.turkishId,
    required this.name,
    required this.surname,
    required this.password,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.interests,
    required this.hasDriverLicense,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'turkish_id': turkishId,
      'name': name,
      'surname': surname,
      'password': password,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'marital_status': maritalStatus ? 1 : 0,
      'interests': interests.join(','),
      'hasDriver_license': hasDriverLicense ? 1 : 0,
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      turkishId: map['turkish_id'],
      name: map['name'],
      surname: map['surname'],
      password: map['password'],
      dateOfBirth: DateTime.parse(map['date_of_birth']),
      maritalStatus: map['marital_status'] == 1,
      interests: List<String>.from(map['interests'].split(',')),
      hasDriverLicense: map['driver_license'] == 1,
    );
  }
}