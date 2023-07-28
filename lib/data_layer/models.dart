class UserModel {
  UserModel(this.id, this.name);

  final int id;
  final String name;
}

class BalabceModel {
  BalabceModel(this.user, this.balance);

  final UserModel user;
  final double balance;
}

abstract class BaseModel {}
