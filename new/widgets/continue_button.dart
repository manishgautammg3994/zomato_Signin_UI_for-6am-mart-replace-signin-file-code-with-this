part of sign_in;

class _ContinueButton extends GetView {
  _ContinueButton(
     {@required this.fixedchild,
      @required this.horizontalPadding,
      @required this.isLoading,
      @required this.loadingchild,
      @required this.minimumSize,
      @required this.onPressed,
      @required this.elevation,
      @required this.primary,
      Key key})
      : super(key: key);

  final bool isLoading;
  final Function() onPressed;
  Widget loadingchild;
  Widget fixedchild;
  double horizontalPadding;
  double elevation;
  Color primary;

  Size minimumSize;
  @override
  Widget build(BuildContext context) {
    return AsyncButton(
      loadingchild: loadingchild,
      style: ElevatedButton.styleFrom(
          primary: primary,
          elevation: elevation,
          minimumSize: minimumSize,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onPressed,
      child: fixedchild,
      isLoading: isLoading,
    ).paddingSymmetric(horizontal: horizontalPadding);
  }
}
