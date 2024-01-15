
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.inputType = TextInputType.text,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        const Gap(10),
        TextFormField(
          cursorColor: Colors.black,
          readOnly: readOnly,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.amber[50],
          ),
          onChanged: (value) {},
          maxLines: maxLines,
          keyboardType: inputType,
        )
      ],
    );
  }
}
