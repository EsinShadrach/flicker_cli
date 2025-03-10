import 'dart:io';
import 'package:flicker_cli/update_pubspec.dart';

void initializeFlicker({bool overwrite = false}) {
  final flickerPath = Directory('flicker');
  bool flickerExists = flickerPath.existsSync();

  if (flickerExists && !overwrite) {
    print('Flicker is already initialized.');
    return;
  }

  print('Creating Flicker package...');

  final createPackage = Process.runSync(
    'flutter',
    [
      'create',
      '--template=package',
      'flicker',
    ],
  );

  final neededPackages = [
    'infamous_squircle',
  ];

  if (createPackage.exitCode == 0) {
    for (final package in neededPackages) {
      final installPackage = Process.runSync(
        'flutter',
        [
          'pub',
          'add',
          package,
        ],
      );

      if (installPackage.exitCode != 0) {
        print('❌ Error: Failed to install $package');
        return;
      } else {
        print('✅ Successfully installed $package');
      }
    }
  }

  final pubspecFile = File('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    updatePubspec();
  }

  // Delete test folder
  final testFolder = Directory('flicker/test');
  if (testFolder.existsSync()) {
    testFolder.deleteSync(recursive: true);
    print('✅ Deleted test folder.');
  }

  // Create necessary directories inside flicker/lib
  final directories = [
    'widgets',
    'utils',
  ];

  for (final directory in directories) {
    createDirectoryAndExport('flicker/lib/$directory', directory);
  }

  // Re-write the contents of ~/flicker/lib/flicker.dart to include the export
  updateFlickerFile(directories);

  print('Flicker package initialized. Run `dart pub get`.');
}

void createDirectoryAndExport(String dirPath, String directory) {
  final dir = Directory(dirPath);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
    print('✅ Created $directory directory.');
  }

  final exportFile = File('$dirPath/$directory.dart');
  if (!exportFile.existsSync()) {
    exportFile.writeAsStringSync('// Export components here\n');
    print('✅ Created $directory.dart for exports.');
  }
}

void updateFlickerFile(List<String> directories) {
  final flickerFile = File('flicker/lib/flicker.dart');
  if (flickerFile.existsSync()) {
    // Clear the file contents...
    flickerFile.writeAsStringSync('');

    // Collect all export statements
    final exportStatements = directories.map((directory) {
      return "export '$directory/$directory.dart';";
    }).join('\n');

    // Write the export statements to the file
    flickerFile.writeAsStringSync(exportStatements);

    print('✅ Updated flicker.dart with export statements.');
  }
}
