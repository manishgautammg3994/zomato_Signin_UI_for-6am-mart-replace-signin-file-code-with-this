part of sign_in;

Widget _buildTitle({double fontSize, String fontFamily, Color color,
    FontWeight fontWeight}) {
  return Center(
      child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: "India's #1 Food Delivery \n and Dining App",
      style: TextStyle(
          color: color,
          overflow: TextOverflow.visible,
          fontSize: fontSize, //set this dynamically,
          fontFamily: fontFamily,
          fontWeight: fontWeight
          //  FontWeight.w800
          ),
    ),
  ));
}
