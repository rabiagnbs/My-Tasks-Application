
import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:flutter/material.dart';

class DisplayWhiteText extends StatelessWidget {
  const DisplayWhiteText({
    super.key,
    required this.text,
    this.fontsize,
    this.fontWeight});

  final String text;
  final double? fontsize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: context.textTheme.headlineSmall?.copyWith(
      color: context.colorScheme.surface,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: 20,
    ) );
  }
}
