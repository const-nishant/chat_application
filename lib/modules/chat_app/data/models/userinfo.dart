class UserInfo {
  final String username;
  final String email;
  final String phone;
  final String uid;
  UserInfo({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'uid': uid,
    };
  }
}
