import 'dart:io';

void updatePubspec() {
  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    print('❌ Error: pubspec.yaml not found!');
    return;
  }

  final lines = pubspecFile.readAsLinesSync();
  final flickerEntry = '  flicker:\n    path: ./flicker/';

  if (lines.any((line) => line.contains('flicker:'))) {
    print('✅ flicker is already in pubspec.yaml');
    return;
  }

  final dependenciesIndex = lines.indexWhere(
    (line) => line.trim() == 'dependencies:',
  );
  if (dependenciesIndex == -1) {
    print('❌ Error: dependencies section not found in pubspec.yaml!');
    return;
  }

  lines.insert(dependenciesIndex + 1, flickerEntry);

  pubspecFile.writeAsStringSync(lines.join('\n'));

  print('✅ Successfully added flicker to pubspec.yaml!');
}
