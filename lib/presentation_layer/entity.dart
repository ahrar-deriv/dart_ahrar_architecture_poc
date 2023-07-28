class UserEntity extends BaseEntity {
  final int id;
  final String name;

  UserEntity(this.id, this.name);
}

class BalanceEntity extends BaseEntity {
  final UserEntity user;
  final double balance;

  BalanceEntity(this.user, this.balance);
}

abstract class BaseEntity {}
