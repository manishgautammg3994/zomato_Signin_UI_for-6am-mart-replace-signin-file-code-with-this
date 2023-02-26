import 'package:flutter/material.dart';

class AsyncButton extends StatelessWidget {
  const AsyncButton({
    @required this.onPressed,
    @required this.child,
    @required this.isLoading,
    this.style,
    this.circularIndicatorRadius = 15,
     @required this.loadingchild,
    Key key,
  }) : super(key: key);

  final ButtonStyle style;
  final Widget child;
  final Function() onPressed;
  final bool isLoading;
  final double circularIndicatorRadius;
  final Widget loadingchild;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: (onPressed == null || isLoading) ? null : onPressed,
      child: (isLoading)
          ? SizedBox(
              height: circularIndicatorRadius,
              width: circularIndicatorRadius,
              child: loadingchild,
            )
          : child,
    );
  }
}
