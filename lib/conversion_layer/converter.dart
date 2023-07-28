import 'dart:convert';

import 'package:dart_ahrar_architecture_poc/data_layer/models.dart';
import 'package:dart_ahrar_architecture_poc/presentation_layer/entity.dart';

BaseEntity conver(BaseModel model) {
  String json = jsonEncode(model);
}
