part of sign_in;

class _footer_policy_btn extends StatelessWidget {
  _footer_policy_btn(
      {@required this.onPressedTS, Key key, this.onPressedPP, this.onPressedCP})
      : super(key: key);

  final Function() onPressedTS; //TODO
  final Function() onPressedPP; //TODO
  final Function() onPressedCP; //TODO
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "By continuing,you are agree to our \n",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 14),
              children: [
                TextSpan(
                    text: "Terms of Service,  ",
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Terms of Service  ');
                        Get.toNamed("/html", parameters: {
                          'page': 'terms-and-condition'
                        }); // Get.parameters['page'] == 'terms-and-condition'
                      }),
                /////
                TextSpan(
                    text: "Privacy Policy,  ",
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('PP"');
                        Get.toNamed("/html",
                            parameters: {'page': 'privacy-policy'});
                      }),
                ///////

                TextSpan(
                    text: "Cancellation Policy",
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('cp "'); //'cancellation-policy'
                        Get.toNamed("/html",
                            parameters: {'page': 'cancellation-policy'});
                      }),
              ]),
        ),
      ],
    );
  }
}
