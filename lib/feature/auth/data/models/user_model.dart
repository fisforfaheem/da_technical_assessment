class UserEntity {
  String? username;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? gender;
  num? balance;
  bool? isVerified;

  UserEntity({
    this.username,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.gender,
    this.isVerified,
    this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'gender': gender,
      'is_verified': isVerified,
      'balance': balance,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      username: map['username'] ?? '-',
      email: map['email'] ?? '-',
      password: map['password'] ?? '-',
      phone: map['phone'] ?? '-',
      address: map['address'] ?? '-',
      gender: map['gender'] ?? '-',
      isVerified: map['is_verified'] ?? false,
      balance: map['balance'] ?? 0.0,
    );
  }

  static List<UserEntity> fromJsonToList(Map<String, dynamic> data) {
    return (data.values.map((item) => UserEntity.fromMap(item))).toList();
  }
}
