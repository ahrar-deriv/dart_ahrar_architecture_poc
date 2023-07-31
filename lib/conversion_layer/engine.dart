import 'dart:mirrors';

import 'package:dart_ahrar_architecture_poc/conversion_layer/engine_layer_dependency_resolver.dart';
import 'package:dart_ahrar_architecture_poc/data_layer/data_layer.dart';
import 'package:dart_ahrar_architecture_poc/presentation_layer/entity.dart';

class EngineLayer {
  final DependencyResolver _dependencyResolver;
  final DataLayer _dataLayer;

  EngineLayer(String xmlContent)
      : _dependencyResolver = DependencyResolver(xmlContent),
        _dataLayer = DataLayer();

  Future<T> convertToDataModel<T extends Object>(
      BaseEntity presentationModel) async {
    final dataModelInstance = _createDataModelInstance<T>();
    final presentationMirror = reflect(presentationModel);
    final dataModelMirror = reflect(dataModelInstance);

    // Iterate through fields in the presentation model
    await Future.forEach(presentationMirror.type.declarations.values,
        (field) async {
      if (field is VariableMirror) {
        final fieldName = MirrorSystem.getName(field.simpleName);
        final fieldValue =
            presentationMirror.getField(field.simpleName).reflectee;

        // Find the corresponding field in the data model
        final dataField = dataModelMirror.type.declarations[field.simpleName];
        if (dataField is VariableMirror) {
          // Check for dependencies
          final dependencies =
              _dependencyResolver.getDependenciesForField(fieldName);
          if (dependencies.isNotEmpty) {
            for (final dependencyFieldName in dependencies) {
              final dependencyField = presentationMirror.type
                  .declarations[MirrorSystem.getSymbol(dependencyFieldName)];
              if (dependencyField is VariableMirror) {
                final dependencyFieldValue = presentationMirror
                    .getField(dependencyField.simpleName)
                    .reflectee;

                // If the dependent field is null, fetch data and update the presentation model
                if (dependencyFieldValue == null) {
                  // Create a temporary presentation model for dependency resolution
                  final dependencyPresentationModel =
                      _createTempPresentationModel(
                          presentationModel.runtimeType);
                  dependencyPresentationModel.setField(
                      dependencyField.simpleName, null);

                  final dependencyDataModel = await convertToDataModel(
                      await _dataLayer.fetchData(dependencyPresentationModel));
                  presentationModel.setField(
                      dependencyField.simpleName, dependencyDataModel);
                }
              }
            }
          }

          // Set the value of the field in the data model
          dataModelMirror.setField(field.simpleName, fieldValue);
        }
      }
    });

    return dataModelInstance;
  }

  T _createDataModelInstance<T extends Object>() {
    // Get the ClassMirror for the data model
    final dataModelType = reflectType(T);
    final dataModelClassMirror = dataModelType as ClassMirror;

    // Get the constructor of the data model
    final dataModelConstructor =
        dataModelClassMirror.declarations.values.firstWhere(
      (declaration) =>
          declaration is MethodMirror &&
          declaration.isConstructor &&
          declaration.constructorName != Symbol(''),
    ) as MethodMirror;

    // Invoke the constructor to create an instance of the data model
    final dataModelInstance = dataModelClassMirror.newInstance(
      dataModelConstructor.constructorName,
      [],
      // Add named constructor parameters if needed, like: {#user: null, #balance: null}
    );

    return dataModelInstance.reflectee;
  }

  BaseEntity _createTempPresentationModel(Type presentationModelType) {
    final presentationTypeMirror = reflectType(presentationModelType);
    final presentationClassMirror = presentationTypeMirror as ClassMirror;
    final presentationConstructor =
        presentationClassMirror.declarations.values.firstWhere(
      (declaration) =>
          declaration is MethodMirror &&
          declaration.isConstructor &&
          declaration.constructorName != Symbol(''),
    ) as MethodMirror;

    // Create an instance of the presentation model with all fields set to null
    final presentationInstance = presentationClassMirror.newInstance(
      presentationConstructor.constructorName,
      [],
      // Add named constructor parameters if needed, like: {#id: null, #name: null, #user: null, #balance: null}
    );

    return presentationInstance.reflectee;
  }
}
