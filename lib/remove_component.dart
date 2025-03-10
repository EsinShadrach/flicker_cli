import 'dart:io';

void removeComponent(String component) {
  // Paths to the component files and the export file
  final componentPath = 'flicker/lib/widgets/$component/';
  final exportFilePath = 'flicker/lib/widgets/widgets.dart';

  // Check if the component file exists at the destination
  final componentDir = Directory(componentPath);
  if (!componentDir.existsSync()) {
    print('❌ Error: $component does not exist in the destination!');
    return;
  }

  // Delete the component file at the destination
  componentDir.deleteSync(recursive: true);
  print('✅ Removed $component.dart from flicker/lib/widgets/$component/');

  // Remove the export statement for the component in widgets.dart
  final exportFile = File(exportFilePath);

  if (exportFile.existsSync()) {
    final exportText = "export '$component/$component.dart';\n";
    final content = exportFile.readAsStringSync();

    // Remove the exact export line from the content
    final newContent = content.replaceAll(exportText, '');

    // Write the updated content back to widgets.dart
    exportFile.writeAsStringSync(newContent);
    print('✅ Removed export statement for $component from widgets.dart');
  }
}
