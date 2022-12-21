class User {
  final String turkishId;
  final String name;
  final String surname;
  final String password;
  final String dateOfBirth;
  final String maritalStatus;
  final List<String> interests;
  final bool hasDriverLicense;

  User({
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
      'turkishId': turkishId,
      'name': name,
      'surname': surname,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'maritalStatus': maritalStatus,
      'interests': interests.join(','),
      'hasDriverLicense': hasDriverLicense ? 1 : 0,
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      turkishId: map['turkishId'],
      name: map['name'],
      surname: map['surname'],
      password: map['password'],
      dateOfBirth: map['dateOfBirth'],
      maritalStatus: map['maritalStatus'],
      interests: List<String>.from(map['interests'].split(',')),
      hasDriverLicense: map['hasDriverLicense'] == 1,
    );
  }
}