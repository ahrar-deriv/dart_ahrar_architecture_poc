import 'dart:math';

import 'models.dart';

Future<UserModel> getUser() async => Future<UserModel>.delayed(
      const Duration(seconds: 1),
      () => UserModel(1, 'Ahrar'),
    );

Stream<BalabceModel> getBalabce(UserModel user) =>
    Stream<BalabceModel>.periodic(
      const Duration(seconds: 1),
      (int count) => BalabceModel(user, Random().nextDouble() * 1000),
    );
