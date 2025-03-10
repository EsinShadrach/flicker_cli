import 'dart:io';

void addComponent(String component) {
  final mainPackagePath = '/Users/mac/codes/projects/2025/flicker_cli';

  // Source path to the component
  final source = File(
    '$mainPackagePath/components/$component/$component.dart',
  );

  // Destination path in the CLI tool
  final destination = File('flicker/lib/widgets/$component/$component.dart');

  print('🔍 Checking if source exists');

  if (!source.existsSync()) {
    print('❌ Error: Source file does not exist!');
    return;
  }

  // Ensure the destination directory exists
  destination.parent.createSync(recursive: true);

  // Copy the file from source to destination
  source.copySync(destination.path);

  // Add export statement to widgets.dart
  final exportStatement = "export '$component/$component.dart';\n";
  final widgetFile = File('flicker/lib/widgets/widgets.dart');

  if (widgetFile.existsSync()) {
    widgetFile.writeAsStringSync(
      exportStatement,
      mode: FileMode.append,
    );

    print('✅ Added export for $component to widgets.dart');
  } else {
    print('❌ Error: widgets.dart file does not exist!');
  }

  print('✅ Successfully copied $component to flicker/lib/widgets/$component/');
}
