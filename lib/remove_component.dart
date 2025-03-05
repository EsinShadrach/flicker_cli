import 'dart:io';

void removeComponent(String name) {
  final targetPath = 'flicker/lib/widgets/$name.dart';
  final flickerFile = File('flicker/lib/flicker.dart');

  if (!File(targetPath).existsSync()) {
    print('Component "$name" does not exist.');
    return;
  }

  // Delete component
  File(targetPath).deleteSync();

  // Remove export
  final exports = flickerFile.readAsStringSync().split('\n');
  exports.removeWhere((line) => line.contains("export 'widgets/$name.dart';"));
  flickerFile.writeAsStringSync(exports.join('\n'));

  print('Removed "$name" component.');
}
