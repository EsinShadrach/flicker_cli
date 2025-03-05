import 'dart:io';
import 'package:args/args.dart';
import 'package:flicker_cli/flicker_cli.dart';

void main(List<String> arguments) {
  final parser =
      ArgParser()
        ..addCommand('init')
        ..addCommand('add')
        ..addCommand('remove');

  final argResults = parser.parse(arguments);
  final command = argResults.command?.name;

  switch (command) {
    case 'init':
      initializeFlicker();
      break;
    case 'add':
      final component = argResults.command!.rest.firstOrNull;
      if (component == null) {
        print('Usage: dart run flicker_cli add <component>');
        exit(1);
      }
      addComponent(component);
      break;
    case 'remove':
      final component = argResults.command!.rest.firstOrNull;
      if (component == null) {
        print('Usage: dart run flicker_cli remove <component>');
        exit(1);
      }
      removeComponent(component);
      break;
    default:
      print('Usage: dart run flicker_cli <command>');
      print('Commands: init, add <component>, remove <component>');
  }
}

void initializeFlicker() {
  final flickerPath = Directory('flicker');
  if (flickerPath.existsSync()) {
    print('Flicker is already initialized.');
    return;
  }

  // Create the package
  print('Creating Flicker package...');
  Process.runSync('flutter', ['create', '--template=package', 'flicker']);

  // Modify pubspec.yaml to include flicker as a dependency
  final pubspecFile = File('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    updatePubspec();
  }

  print('Flicker package initialized. Run `dart pub get`.');
}
