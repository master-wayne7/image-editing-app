import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(
          TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
