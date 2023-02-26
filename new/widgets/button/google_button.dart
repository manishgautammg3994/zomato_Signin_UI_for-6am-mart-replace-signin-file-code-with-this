part of sign_in;

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({@required this.onPressed, Key key}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey[200],
      child: IconButton(
        onPressed: onPressed,
        icon:
            // Icon(Icons.g_mobiledata),
            Image.asset("assets/image/google.png"),
        tooltip: "Google",
      ),
    );
  }
}
