import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPress;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton({
    super.key,
    this.height,
    this.width,
    required this.text,
    this.margin,
    this.backgroundColor,
    this.textStyle,
    this.onPress,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.07,
        width: width ?? MediaQuery.of(context).size.width,
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
