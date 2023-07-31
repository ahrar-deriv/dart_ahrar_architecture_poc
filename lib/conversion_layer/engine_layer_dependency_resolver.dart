import 'package:xml/xml.dart' as xml;

class DependencyResolver {
  final Map<String, List<String>> _fieldDependencies;

  DependencyResolver(String xmlContent)
      : _fieldDependencies = _parseDependencies(xmlContent);

  static Map<String, List<String>> _parseDependencies(String xmlContent) {
    final xmlDocument = xml.XmlDocument.parse(xmlContent);
    final dependenciesElement = xmlDocument.rootElement;

    final Map<String, List<String>> fieldDependencies = {};

    for (final fieldElement in dependenciesElement.children) {
      final fieldName = fieldElement.getAttribute('name');
      final dependsOnField = fieldElement.getAttribute('dependsOn');

      if (fieldName != null && dependsOnField != null) {
        fieldDependencies[fieldName] = [dependsOnField];
      }
    }

    return fieldDependencies;
  }

  List<String> getDependenciesForField(String fieldName) {
    return _fieldDependencies[fieldName] ?? [];
  }
}
