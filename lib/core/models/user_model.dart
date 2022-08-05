class UserModel {
  final String email;
  final String password;
  final String id;

  UserModel({required this.email, required this.password, required this.id});

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        id: map['id'] ?? '');
  }
}
