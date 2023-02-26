part of sign_in;

class _ContinueText extends StatelessWidget {
  final String midText;
  double intent;
  double endintent;
  double thickness;
  Color color;
  double fontSize;
  FontWeight fontWeight;

   _ContinueText(
      {Key key,
      @required this.midText,
      @required this.intent,
      @required this.endintent,
      @required this.thickness,
      @required this.color,
      @required this.fontSize,
      @required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: intent,
            endIndent: endintent, //Todo dynamic
            thickness: thickness,
          ),
        ),
        Text(
          "$midText",
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        Expanded(
          child: Divider(
            indent: intent, //TODO dynamic
            endIndent: endintent,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
