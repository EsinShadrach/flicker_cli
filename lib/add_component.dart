import 'dart:io';

void addComponent(String component) {
  final source = File('components/$component.dart');
  final destination = File('flicker/lib/widgets/$component.dart');

  print(
    '🔍 Checking if source exists: ${source.path} => ${source.existsSync()}',
  );

  if (!source.existsSync()) {
    print('❌ Error: Source file does not exist!');
    return;
  }

  destination.createSync(recursive: true);
  source.copySync(destination.path);

  print('✅ Successfully copied $component.dart to flicker/lib/widgets/');
}

void updatePubspec() {
  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    print('❌ Error: pubspec.yaml not found!');
    return;
  }

  final lines = pubspecFile.readAsLinesSync();
  final flickerEntry = '  flicker:\n    path: ./flicker/';

  // Check if flicker is already added
  if (lines.any((line) => line.contains('flicker:'))) {
    print('✅ flicker is already in pubspec.yaml');
    return;
  }

  // Find dependencies section
  final dependenciesIndex = lines.indexWhere(
    (line) => line.trim() == 'dependencies:',
  );
  if (dependenciesIndex == -1) {
    print('❌ Error: dependencies section not found in pubspec.yaml!');
    return;
  }

  // Insert flicker dependency after "dependencies:"
  lines.insert(dependenciesIndex + 1, flickerEntry);

  pubspecFile.writeAsStringSync(lines.join('\n'));

  print('✅ Successfully added flicker to pubspec.yaml!');
}
