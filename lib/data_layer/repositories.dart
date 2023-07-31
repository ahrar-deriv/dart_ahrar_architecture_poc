import 'dart:math';

import 'models.dart';

Future<UserModel> getUser() async => Future<UserModel>.delayed(
      const Duration(seconds: 1),
      () => UserModel(id: 1, name: 'Ahrar'),
    );

Stream<BalanceModel> getBalance(UserModel user) =>
    Stream<BalanceModel>.periodic(
      const Duration(seconds: 1),
      (int count) =>
          BalanceModel(user: user, balance: Random().nextDouble() * 1000),
    );
