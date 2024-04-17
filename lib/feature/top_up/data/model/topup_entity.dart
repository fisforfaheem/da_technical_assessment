class TopUpEntity {
  String? phoneNumber;
  String? nickname;
  num? amount;
  String? dateTime;

  TopUpEntity({
    this.phoneNumber,
    this.nickname,
    this.amount,
    this.dateTime,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'nickname': nickname,
      'amount': amount,
      'dateTime': dateTime,
    };
  }

  // from map
  TopUpEntity.fromMap(Map<String, dynamic> map) {
    phoneNumber = map['phoneNumber'];
    nickname = map['nickname'];
    amount = map['amount'];
    dateTime = map['dateTime'];
  }

  //copywith
  TopUpEntity copyWith({
    String? phoneNumber,
    String? nickname,
    num? amount,
    String? dateTime,
  }) {
    return TopUpEntity(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nickname: nickname ?? this.nickname,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
