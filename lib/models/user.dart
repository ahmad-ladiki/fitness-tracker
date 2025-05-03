class User {
  final String name;
  final String email;
  final String password;
  final int age;
  final String gender;
  final String? profileImagePath;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    this.profileImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'profileImagePath': profileImagePath,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      gender: json['gender'],
      profileImagePath: json['profileImagePath'],
    );
  }
} 