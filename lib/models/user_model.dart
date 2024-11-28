class UserModel {
  final String? name;
  final String? email;
  final String? uId;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
  });

  UserModel.fromJson(Map<String, dynamic>? json)
      : name = json?['name'],
        email = json?['email'],
        uId = json?['uId'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }
}
