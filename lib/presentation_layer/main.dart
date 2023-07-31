import 'package:dart_ahrar_architecture_poc/conversion_layer/engine.dart';
import 'package:dart_ahrar_architecture_poc/presentation_layer/entity.dart';

void main() async {
  // XML content for defining dependencies
  const xmlContent = '''
    <dependencies>
      <User>
        <Balance/>
      </User>
    </dependencies>
  ''';

  final engineLayer = EngineLayer(xmlContent);

  final userEntity = UserEntity(1, 'Ahrar');

  final balanceEntity = BalanceEntity(userEntity, 0.0);

  final balanceModel =
      await engineLayer.convertToDataModel<BalanceEntity>(balanceEntity);

  // Print the balance
  print('Balance: ${balanceModel.balance}');
}
