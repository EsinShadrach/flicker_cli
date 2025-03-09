import 'package:flutter/widgets.dart';

class FlickerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const FlickerButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (pointer) {
        ///
        debugPrint("Tap inside");
      },
      child: Text(text),
    );
  }
}
