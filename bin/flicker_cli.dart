import 'dart:io';

import 'package:args/args.dart';
import 'package:flicker_cli/lib.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand('init')
    ..addCommand('add')
    ..addCommand('remove')
    ..addCommand('re-init');

  final argResults = parser.parse(arguments);
  final command = argResults.command?.name;

  switch (command) {
    case 're-init':
      initializeFlicker(overwrite: true);
      break;
    case 'init':
      initializeFlicker();
      break;
    case 'add':
      final component = argResults.command!.rest.firstOrNull;
      if (component == null) {
        print('Usage: flicker add <component>');
        exit(1);
      }
      addComponent(component);
      break;
    case 'remove':
      final component = argResults.command!.rest.firstOrNull;
      if (component == null) {
        print('Usage: flicker remove <component>');
        exit(1);
      }
      removeComponent(component);
      break;
    default:
      print('Usage: flicker <command>');
      print('Commands: init, add <component>, remove <component>');
  }
}
