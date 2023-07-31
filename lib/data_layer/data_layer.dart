// data_layer.dart

import 'dart:async';
import 'dart:math';

import 'package:dart_ahrar_architecture_poc/data_layer/models.dart';

class DataLayer {
  Future<T> fetchData<T>(T model) async {
    if (model is UserModel) {
      return Future<T>.delayed(
        const Duration(seconds: 1),
        () => model,
      );
    } else if (model is BalanceModel) {
      return Stream<BalanceModel>.periodic(
        const Duration(seconds: 1),
        (int count) => BalanceModel(
            user: model.user, balance: Random().nextDouble() * 1000),
      ).first as T;
    }

    throw ArgumentError('Data model type not supported.');
  }
}
