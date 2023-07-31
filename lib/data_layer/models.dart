class UserModel {
  UserModel({required this.id, required this.name});

  final int id;
  final String name;
}

class BalanceModel {
  BalanceModel({required this.user, required this.balance});

  final UserModel user;
  final double balance;
}

abstract class BaseModel {}
