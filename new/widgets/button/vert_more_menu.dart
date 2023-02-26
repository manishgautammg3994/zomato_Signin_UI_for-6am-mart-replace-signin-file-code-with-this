part of sign_in;

class _VertMoreButton extends StatelessWidget {
  const _VertMoreButton({@required this.onPressed, Key key}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey[
          200], //D:\jaibharat\User app and web\efood_multivendor\assets\image\facebook.png
      child: IconButton(
        onPressed: onPressed,
        icon:
            // Icon(Icons.g_mobiledata),
            Image.asset("assets/image/facebook.png"),
        tooltip: "Google",
      ),
    );
  }
}
