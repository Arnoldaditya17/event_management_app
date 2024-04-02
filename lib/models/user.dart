class User {
  int _id;
  String _firstname;
  String _lastname;
  String _email;
  String _phone;
  String _userProfile;

  User.empty()
      : _id = 0,
        _firstname = '',
        _lastname = '',
        _email = '',
        _phone = '',
        _userProfile = '';

  User({
    required int id,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String userProfile,
  })  : _id = id,
        _firstname = firstname,
        _lastname = lastname,
        _email = email,
        _phone = phone,
        _userProfile = userProfile;

  // Getters
  int get id => _id;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get email => _email;
  String get phone => _phone;
  String get userProfile => _userProfile; // Getter for userProfile

  // Setters
  set id(int value) {
    _id = value;
  }

  set firstname(String value) {
    _firstname = value;
  }

  set lastname(String value) {
    _lastname = value;
  }

  set email(String value) {
    _email = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set userProfile(String value) {
    _userProfile = value;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      userProfile: json['userProfile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'firstname': _firstname,
      'lastname': _lastname,
      'email': _email,
      'phone': _phone,
      'userProfile': _userProfile,
    };
  }
}
