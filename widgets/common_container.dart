
import 'package:calismalarim_app/TasksApp/utils/extensions.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer ({super.key, this.child, this.height});
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final deviceSize= context.deviceSize;
    return Container(
        width: deviceSize.width,
        height: deviceSize.height * 0.3,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
    color: Colors.purple[100],
    ),
    child: child,);
  }
}
