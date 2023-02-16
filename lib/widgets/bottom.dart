import 'package:flutter/material.dart';
import 'package:testflutter/helper/style.dart';
import 'package:testflutter/helper/text_helper.dart';

class MainBottom extends StatelessWidget {
  final String title;
  final double? width, height;
  final VoidCallback? function;
  final Color? primary;
  final TextStyle? style;
  final Widget? child;
  const MainBottom(
      {Key? key,
      required this.title,
      this.height,
      this.width,
      this.child,
      this.function,
      this.style,
      this.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primary ?? ColorHelper.baseColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          onPressed: function,
          child: child ??
              Text(
                title,
                style: style ?? TextHelper.white16w600,
              )),
    );
  }
}
