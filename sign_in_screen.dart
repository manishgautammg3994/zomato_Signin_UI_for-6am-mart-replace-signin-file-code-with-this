// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:country_code_picker/country_code.dart';
// import 'package:efood_multivendor/controller/auth_controller.dart';
// import 'package:efood_multivendor/controller/localization_controller.dart';
// import 'package:efood_multivendor/controller/splash_controller.dart';
// import 'package:efood_multivendor/helper/responsive_helper.dart';
// import 'package:efood_multivendor/helper/route_helper.dart';
// import 'package:efood_multivendor/util/dimensions.dart';
// import 'package:efood_multivendor/util/images.dart';
// import 'package:efood_multivendor/util/styles.dart';
// import 'package:efood_multivendor/view/base/custom_button.dart';
// import 'package:efood_multivendor/view/base/custom_snackbar.dart';
// import 'package:efood_multivendor/view/base/custom_text_field.dart';
// import 'package:efood_multivendor/view/base/web_menu_bar.dart';
// import 'package:efood_multivendor/view/screens/auth/widget/code_picker_widget.dart';
// import 'package:efood_multivendor/view/screens/auth/widget/condition_check_box.dart';
// import 'package:efood_multivendor/view/screens/auth/widget/guest_button.dart';
// import 'package:efood_multivendor/view/screens/auth/widget/social_login_widget.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:phone_number/phone_number.dart';

// class SignInScreen extends StatefulWidget {
//   final bool exitFromApp;
//   SignInScreen({@required this.exitFromApp});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final FocusNode _phoneFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _countryDialCode;
//   bool _canExit = GetPlatform.isWeb ? true : false;

//   @override
//   void initState() {
//     super.initState();

//     _countryDialCode = Get.find<AuthController>().getUserCountryCode().isNotEmpty ? Get.find<AuthController>().getUserCountryCode()
//         : CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country).dialCode;
//     _phoneController.text =  Get.find<AuthController>().getUserNumber() ?? '';
//     _passwordController.text = Get.find<AuthController>().getUserPassword() ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if(widget.exitFromApp) {
//           if (_canExit) {
//             if (GetPlatform.isAndroid) {
//               SystemNavigator.pop();
//             } else if (GetPlatform.isIOS) {
//               exit(0);
//             } else {
//               Navigator.pushNamed(context, RouteHelper.getInitialRoute());
//             }
//             return Future.value(false);
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('back_press_again_to_exit'.tr, style: TextStyle(color: Colors.white)),
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 2),
//               margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//             ));
//             _canExit = true;
//             Timer(Duration(seconds: 2), () {
//               _canExit = false;
//             });
//             return Future.value(false);
//           }
//         }else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : !widget.exitFromApp ? AppBar(leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).textTheme.bodyText1.color),
//         ), elevation: 0, backgroundColor: Colors.transparent) : null,
//         body: SafeArea(child: Center(
//           child: Scrollbar(
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//               child: Center(
//                 child: Container(
//                   width: context.width > 700 ? 700 : context.width,
//                   padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
//                   decoration: context.width > 700 ? BoxDecoration(
//                     color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                     boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
//                   ) : null,
//                   child: GetBuilder<AuthController>(builder: (authController) {

//                     return Column(children: [

//                       Image.asset(Images.logo, width: 150),
//                       SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

//                       Text('sign_in'.tr.toUpperCase(), style: robotoBlack.copyWith(fontSize: 30)),
//                       SizedBox(height: 50),

//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                           color: Theme.of(context).cardColor,
//                           boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
//                         ),
//                         child: Column(children: [

//                           Row(children: [
//                             CodePickerWidget(
//                               onChanged: (CountryCode countryCode) {
//                                 _countryDialCode = countryCode.dialCode;
//                               },
//                               initialSelection: _countryDialCode != null ? Get.find<AuthController>().getUserCountryCode().isNotEmpty ? Get.find<AuthController>().getUserCountryCode()
//                                   : CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country).code : Get.find<LocalizationController>().locale.countryCode,
//                               favorite: [Get.find<AuthController>().getUserCountryCode().isNotEmpty ? Get.find<AuthController>().getUserCountryCode()
//                                   : CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country).code],
//                               countryFilter: [_countryDialCode],
//                               enabled: false,
//                               showDropDownButton: false,
//                               padding: EdgeInsets.zero,
//                               showFlagMain: true,
//                               flagWidth: 30,
//                               dialogBackgroundColor: Theme.of(context).cardColor,
//                               textStyle: robotoRegular.copyWith(
//                                 fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1.color,
//                               ),
//                             ),
//                             Expanded(flex: 1, child: CustomTextField(
//                               hintText: 'phone'.tr,
//                               controller: _phoneController,
//                               focusNode: _phoneFocus,
//                               nextFocus: _passwordFocus,
//                               inputType: TextInputType.phone,
//                               divider: false,
//                             )),
//                           ]),
//                           Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE), child: Divider(height: 1)),

//                           CustomTextField(
//                             hintText: 'password'.tr,
//                             controller: _passwordController,
//                             focusNode: _passwordFocus,
//                             inputAction: TextInputAction.done,
//                             inputType: TextInputType.visiblePassword,
//                             prefixIcon: Images.lock,
//                             isPassword: true,
//                             onSubmit: (text) => (GetPlatform.isWeb && authController.acceptTerms)
//                                 ? _login(authController, _countryDialCode) : null,
//                           ),

//                         ]),
//                       ),
//                       SizedBox(height: 10),

//                       Row(children: [
//                         Expanded(
//                           child: ListTile(
//                             onTap: () => authController.toggleRememberMe(),
//                             leading: Checkbox(
//                               activeColor: Theme.of(context).primaryColor,
//                               value: authController.isActiveRememberMe,
//                               onChanged: (bool isChecked) => authController.toggleRememberMe(),
//                             ),
//                             title: Text('remember_me'.tr),
//                             contentPadding: EdgeInsets.zero,
//                             dense: true,
//                             horizontalTitleGap: 0,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute(false, null)),
//                           child: Text('${'forgot_password'.tr}?'),
//                         ),
//                       ]),
//                       SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

//                       ConditionCheckBox(authController: authController),
//                       SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

//                       !authController.isLoading ? Row(children: [
//                         Expanded(child: CustomButton(
//                           buttonText: 'sign_up'.tr, // TODO
//                           transparent: true,
//                           onPressed: () => Get.toNamed(RouteHelper.getSignUpRoute()),
//                         )),
//                         Expanded(child: CustomButton(
//                           buttonText: 'sign_in'.tr,
//                           onPressed: authController.acceptTerms ? () => _login(authController, _countryDialCode) : null,
//                         )),
//                       ]) : Center(child: CircularProgressIndicator()),
//                       SizedBox(height: 30),

// SocialLoginWidget(),

// GuestButton(),

//                     ]);
//                   }),
//                 ),
//               ),
//             ),
//           ),
//         )),
//       ),
//     );
//   }

//   void _login(AuthController authController, String countryDialCode) async {
//     String _phone = _phoneController.text.trim();
//     String _password = _passwordController.text.trim();
//     String _numberWithCountryCode = countryDialCode+_phone;
//     bool _isValid = GetPlatform.isWeb ? true : false;
//     if(!GetPlatform.isWeb) {
//       try {
//         PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
//         _numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
//         _isValid = true;
//       } catch (e) {}
//     }
//     if (_phone.isEmpty) {
//       showCustomSnackBar('enter_phone_number'.tr);
//     }else if (!_isValid) {
//       showCustomSnackBar('invalid_phone_number'.tr);
//     }else if (_password.isEmpty) {
//       showCustomSnackBar('enter_password'.tr);
//     }else if (_password.length < 6) {
//       showCustomSnackBar('password_should_be'.tr);
//     }else {
//       authController.login(_numberWithCountryCode, _password).then((status) async {
//         if (status.isSuccess) {
//           if (authController.isActiveRememberMe) {
//             authController.saveUserNumberAndPassword(_phone, _password, countryDialCode);
//           } else {
//             authController.clearUserNumberAndPassword();
//           }
//           String _token = status.message.substring(1, status.message.length);
//           if(Get.find<SplashController>().configModel.customerVerification && int.parse(status.message[0]) == 0) {
//             List<int> _encoded = utf8.encode(_password);
//             String _data = base64Encode(_encoded);
//             Get.toNamed(RouteHelper.getVerificationRoute(_numberWithCountryCode, _token, RouteHelper.signUp, _data));
//           }else {
//             Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
//           }
//         }else {
//           showCustomSnackBar(status.message);
//         }
//       });
//     }
//   }
// }
////////////////////////////////////down is new///////////
library sign_in;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:efood_multivendor/data/model/body/social_log_in_body.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/auth/widget/code_picker_widget.dart';
import 'package:efood_multivendor/view/screens/auth/widget/condition_check_box.dart';
import 'package:efood_multivendor/view/screens/auth/widget/guest_button.dart';
import 'package:efood_multivendor/view/screens/auth/widget/social_login_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:get/get.dart';

import 'package:efood_multivendor/view/screens/auth/widget/new/widgets/async_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_number/phone_number.dart';

import '../../../../../controller/auth_controller.dart';
import '../../../../../controller/localization_controller.dart';
import '../../../../../controller/splash_controller.dart';

import '../../../../../util/dimensions.dart';
import '../../../../../util/styles.dart';

import '../../base/custom_text_field.dart';
part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/illustration_image.dart';

part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/boldmid_title.dart';
part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/continue_text.dart';
part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/continue_button.dart';
part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/button/google_button.dart';
part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/button/vert_more_menu.dart';
part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/footer_policy_txt_btn.dart';
// part 'package:efood_multivendor/view/screens/auth/widget/new/widgets/phone_text_field.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;

  const SignInScreen({Key key, @required this.exitFromApp}); //TODO add@required

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _countryDialCode;
  bool _canExit = GetPlatform.isWeb ? true : false;
  var authController;

//////2

  @override
  void initState() {
    super.initState();

    authController = Get.find<AuthController>();
    _countryDialCode =
        Get.find<AuthController>().getUserCountryCode().isNotEmpty
            ? Get.find<AuthController>().getUserCountryCode()
            : CountryCode.fromCountryCode(
                    Get.find<SplashController>().configModel.country)
                .dialCode;
    _phoneController.text = Get.find<AuthController>().getUserNumber() ?? '';
    _passwordController.text =
        Get.find<AuthController>().getUserPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ////3
        if (widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0); //never do this for ios <account termination>
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        } else {
          return true;
        }
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 650 || !kIsWeb) {
          ///mobile output
          return Scaffold(
              extendBodyBehindAppBar: true,
              body: Scrollbar(
                  child: SingleChildScrollView(
                reverse: true,
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIllustration(
                        context: context,
                        height: constraints.maxHeight / 2.15,
                        width: constraints.maxWidth),
                    SizedBox(
                      height: constraints.maxHeight / 38,
                    ),
                    _buildTitle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 24),
                    SizedBox(
                      height: constraints.maxHeight / 32,
                    ),
                    _ContinueText(
                      color: Colors.grey,
                      endintent: constraints.maxWidth / 80,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      intent: constraints.maxWidth / 80,
                      midText: 'sign_in'.tr,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 35,
                    ),
                    /////////////phoneBox///////////

                    Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth / 100,
                        ),
                        CodePickerWidget(
                          onChanged: (CountryCode countryCode) {
                            _countryDialCode = countryCode.dialCode;
                          },
                          initialSelection: _countryDialCode != null
                              ? Get.find<AuthController>()
                                      .getUserCountryCode()
                                      .isNotEmpty
                                  ? Get.find<AuthController>()
                                      .getUserCountryCode()
                                  : CountryCode.fromCountryCode(
                                          Get.find<SplashController>()
                                              .configModel
                                              .country)
                                      .code
                              : Get.find<LocalizationController>()
                                  .locale
                                  .countryCode,
                          favorite: [
                            Get.find<AuthController>()
                                    .getUserCountryCode()
                                    .isNotEmpty
                                ? Get.find<AuthController>()
                                    .getUserCountryCode()
                                : CountryCode.fromCountryCode(
                                        Get.find<SplashController>()
                                            .configModel
                                            .country)
                                    .code
                          ],
                          countryFilter: [_countryDialCode],
                          enabled: false,
                          showDropDownButton: false,
                          padding: EdgeInsets.zero,
                          showFlagMain: true,
                          flagWidth: 30,
                          dialogBackgroundColor: Theme.of(context).cardColor,
                          textStyle: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth / 100,
                        ),
                        CustomTextField(
                          hintText: 'phone'.tr,
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          nextFocus: _passwordFocus,
                          inputType: TextInputType.phone,
                          divider: false,
                        ),
                        SizedBox(
                          width: constraints.maxWidth / 100,
                        ),
                      ],
                    ),

                    //////////////////////////////
                    SizedBox(
                      height: constraints.maxHeight / 35,
                    ),
                    ////continue Button
                    GetBuilder<AuthController>(builder: (authController) {
                      return _ContinueButton(
                        fixedchild: Text(
                          "Continue",
                          softWrap: true,
                        ),
                        horizontalPadding: constraints.maxWidth / 20,
                        isLoading: authController.isLoading,
                        loadingchild: CircularProgressIndicator(),
                        minimumSize: Size(constraints.maxWidth,
                            (constraints.maxHeight / 15) + 5),
                        onPressed: () =>
                            _login1(authController, _countryDialCode),
                        elevation: 1,
                        primary: Colors.red,
                      );
                    }),
                    SizedBox(
                      height: constraints.maxHeight / 35,
                    ),
                    _ContinueText(
                      color: Colors.grey,
                      endintent: constraints.maxWidth / 80,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      intent: constraints.maxWidth / 80,
                      midText: 'or',
                      thickness: 1,
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 35,
                    ),
                    if (Get.find<SplashController>()
                            .configModel
                            .socialLogin
                            .isNotEmpty &&
                        (Get.find<SplashController>()
                                .configModel
                                .socialLogin[0]
                                .status ||
                            Get.find<SplashController>()
                                .configModel
                                .socialLogin[1]
                                .status))
                      _buildOtherAuthProvider(),
                    SizedBox(
                      height: constraints.maxHeight / 35,
                    ),
                    // Spacer(),
                    Wrap(children: [
                      _footer_policy_btn(
                        onPressedTS: () {},
                      ),
                    ]),
                  ],
                ),
              )));
        } else {
          return Scaffold(
            appBar: ResponsiveHelper.isDesktop(context)
                ? WebMenuBar()
                : !widget.exitFromApp
                    ? AppBar(
                        leading: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back_ios_rounded,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent)
                    : null,
            body: Scrollbar(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIllustration(
                      context: context,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth / 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight / 38,
                      ),
                      _buildTitle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 24),
                      SizedBox(
                        height: constraints.maxHeight / 32,
                      ),
                      _ContinueText(
                        color: Colors.grey,
                        endintent: constraints.maxWidth / 80,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        intent: constraints.maxWidth / 80,
                        midText: 'sign_in'.tr,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: constraints.maxHeight / 35,
                      ),
                      /////////////phoneBox///////////

                      Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth / 100,
                          ),
                          CodePickerWidget(
                            onChanged: (CountryCode countryCode) {
                              _countryDialCode = countryCode.dialCode;
                            },
                            initialSelection: _countryDialCode != null
                                ? Get.find<AuthController>()
                                        .getUserCountryCode()
                                        .isNotEmpty
                                    ? Get.find<AuthController>()
                                        .getUserCountryCode()
                                    : CountryCode.fromCountryCode(
                                            Get.find<SplashController>()
                                                .configModel
                                                .country)
                                        .code
                                : Get.find<LocalizationController>()
                                    .locale
                                    .countryCode,
                            favorite: [
                              Get.find<AuthController>()
                                      .getUserCountryCode()
                                      .isNotEmpty
                                  ? Get.find<AuthController>()
                                      .getUserCountryCode()
                                  : CountryCode.fromCountryCode(
                                          Get.find<SplashController>()
                                              .configModel
                                              .country)
                                      .code
                            ],
                            countryFilter: [_countryDialCode],
                            enabled: false,
                            showDropDownButton: false,
                            padding: EdgeInsets.zero,
                            showFlagMain: true,
                            flagWidth: 30,
                            dialogBackgroundColor: Theme.of(context).cardColor,
                            textStyle: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth / 200,
                          ),
                          CustomTextField(
                            hintText: 'phone'.tr,
                            controller: _phoneController,
                            focusNode: _phoneFocus,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.phone,
                            divider: false,
                          ),
                          SizedBox(
                            width: constraints.maxWidth / 100,
                          ),
                        ],
                      ),

                      //////////////////////////////
                      SizedBox(
                        height: constraints.maxHeight / 35,
                      ),
                      ////continue Button
                      GetBuilder<AuthController>(builder: (authController) {
                        return _ContinueButton(
                          fixedchild: Text(
                            "Continue",
                            softWrap: true,
                          ),
                          horizontalPadding: constraints.maxWidth / 20,
                          isLoading: authController.isLoading,
                          loadingchild: CircularProgressIndicator(),
                          minimumSize: Size(constraints.maxWidth,
                              (constraints.maxHeight / 15) + 5),
                          onPressed: () =>
                              _login1(authController, _countryDialCode),
                          elevation: 1,
                          primary: Colors.red,
                        );
                      }),
                      SizedBox(
                        height: constraints.maxHeight / 35,
                      ),
                      _ContinueText(
                        color: Colors.grey,
                        endintent: constraints.maxWidth / 80,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        intent: constraints.maxWidth / 80,
                        midText: 'or',
                        thickness: 1,
                      ),
                      SizedBox(
                        height: constraints.maxHeight / 35,
                      ),
                      if (Get.find<SplashController>()
                              .configModel
                              .socialLogin
                              .isNotEmpty &&
                          (Get.find<SplashController>()
                                  .configModel
                                  .socialLogin[0]
                                  .status ||
                              Get.find<SplashController>()
                                  .configModel
                                  .socialLogin[1]
                                  .status))
                        _buildOtherAuthProvider(),
                      SizedBox(
                        height: constraints.maxHeight / 35,
                      ),
                      // Spacer(),
                      Wrap(children: [
                        _footer_policy_btn(
                          onPressedTS: () {},
                        ),
                      ]),
                    ],
                  )
                ],
              ),
            )),
          ); //phonePassLogin(context);

          //desktop and web output
        }
      }),
    );
  }

  Widget _buildOtherAuthProvider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if ((Get.find<SplashController>().configModel.socialLogin.isNotEmpty &&
            Get.find<SplashController>().configModel.socialLogin[0].status))
          _GoogleButton(
            onPressed: () async {
              GoogleSignInAccount _googleAccount = await _googleSignIn.signIn();
              GoogleSignInAuthentication _auth =
                  await _googleAccount.authentication;
              if (_googleAccount != null) {
                Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                  email: _googleAccount.email,
                  token: _auth.idToken,
                  uniqueId: _googleAccount.id,
                  medium: 'google',
                ));
              }
            },
          ),
        if ((Get.find<SplashController>().configModel.socialLogin.isNotEmpty &&
            Get.find<SplashController>().configModel.socialLogin[1].status))
          _VertMoreButton(
            onPressed: () async {
              LoginResult _result = await FacebookAuth.instance
                  .login(permissions: ["public_profile", "email"]);
              if (_result.status == LoginStatus.success) {
                Map _userData = await FacebookAuth.instance.getUserData();
                if (_userData != null) {
                  Get.find<AuthController>()
                      .loginWithSocialMedia(SocialLogInBody(
                    email: _userData['email'],
                    token: _result.accessToken.token,
                    uniqueId: _result.accessToken.userId,
                    medium: 'facebook',
                  ));
                }
              }
            },
          ),
      ],
    );
  }

  ////old//////
  void _login(AuthController authController, String countryDialCode) async {
    String _phone = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _numberWithCountryCode = countryDialCode + _phone;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode =
            '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }
    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
      authController
          .login(_numberWithCountryCode, _password)
          .then((status) async {
        if (status.isSuccess) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(
                _phone, _password, countryDialCode);
          } else {
            authController.clearUserNumberAndPassword();
          }
          String _token = status.message.substring(1, status.message.length);
          if (Get.find<SplashController>().configModel.customerVerification &&
              int.parse(status.message[0]) == 0) {
            List<int> _encoded = utf8.encode(_password);
            String _data = base64Encode(_encoded);
            Get.toNamed(RouteHelper.getVerificationRoute(
                _numberWithCountryCode, _token, RouteHelper.signUp, _data));
          } else {
            Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
          }
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  ///////////do something  for login//// new
  void _login1(AuthController authController, String countryDialCode) async {
    _phoneFocus.unfocus();
    String _phone = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _numberWithCountryCode = countryDialCode + _phone;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode =
            '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }
    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }
    // else if (_password.isEmpty) {
    //   showCustomSnackBar('enter_password'.tr);
    // }else if (_password.length < 6) {
    //   showCustomSnackBar('password_should_be'.tr);
    // }
    else {
      authController
          .phoneExistsInDB(_numberWithCountryCode)
          .then((status) async {
        if (status.isSuccess && (status.message == "exists")) {
          ////////////////////////////////////////////////////////////////////////////////////////////////////// TODO
          Get.toNamed("/otp", parameters: {'number': _numberWithCountryCode});
        } else if (status.isSuccess && (status.message == "not_exists")) {
          showCustomSnackBar("User Not Found , Please Sign UP");
          Get.toNamed("/signup",
              parameters: {'number': _phone, 'countrycode': _countryDialCode});
        } else {
          showCustomSnackBar(status.message);
        }
      });
      //is user exists api call
      ///READ THIS LOGIC
      ///if user exists in database then push to OTP Screen Else Check and Verify For Otp Screen =>

      // authController
      //     .login(_numberWithCountryCode, _password)
      //     .then((status) async {
      //   //TODO password
      //   if (status.isSuccess) {
      //     // if (authController.isActiveRememberMe) {
      //     //   authController.saveUserNumberAndPassword(_phone, _password, countryDialCode);
      //     // } else {
      //     //   authController.clearUserNumberAndPassword();
      //     // }
      //     String _token = status.message.substring(1, status.message.length);
      //     if (Get.find<SplashController>().configModel.customerVerification &&
      //         int.parse(status.message[0]) == 0) {
      //       List<int> _encoded = utf8.encode(_password);
      //       String _data = base64Encode(_encoded);
      //       Get.toNamed(RouteHelper.getVerificationRoute(
      //           _numberWithCountryCode, _token, RouteHelper.signUp, _data));
      //     } else {
      //       Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
      //     }
      //   } else {
      //     showCustomSnackBar(status.message);
      //   }
      // });
    }
  }

//////////old phone pass login/////////

  // Scaffold phonePassLogin(BuildContext context) {
  //   return Scaffold(
  //     appBar: ResponsiveHelper.isDesktop(context)
  //         ? WebMenuBar()
  //         : !widget.exitFromApp
  //             ? AppBar(
  //                 leading: IconButton(
  //                   onPressed: () => Get.back(),
  //                   icon: Icon(Icons.arrow_back_ios_rounded,
  //                       color: Theme.of(context).textTheme.bodyText1.color),
  //                 ),
  //                 elevation: 0,
  //                 backgroundColor: Colors.transparent)
  //             : null,
  //     body: SafeArea(
  //         child: Center(
  //       child: Scrollbar(
  //         child: SingleChildScrollView(
  //           physics: BouncingScrollPhysics(),
  //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
  //           child: Center(
  //             child: Container(
  //               width: context.width > 700 ? 700 : context.width,
  //               padding: context.width > 700
  //                   ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
  //                   : null,
  //               decoration: context.width > 700
  //                   ? BoxDecoration(
  //                       color: Theme.of(context).cardColor,
  //                       borderRadius:
  //                           BorderRadius.circular(Dimensions.RADIUS_SMALL),
  //                       boxShadow: [
  //                         BoxShadow(
  //                             color: Colors.grey[Get.isDarkMode ? 700 : 300],
  //                             blurRadius: 5,
  //                             spreadRadius: 1)
  //                       ],
  //                     )
  //                   : null,
  //               child: GetBuilder<AuthController>(builder: (authController) {
  //                 return Column(children: [
  //                   Image.asset(Images.logo, width: 150),
  //                   SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
  //                   Text('sign_in'.tr.toUpperCase(),
  //                       style: robotoBlack.copyWith(fontSize: 30)),
  //                   SizedBox(height: 50),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius:
  //                           BorderRadius.circular(Dimensions.RADIUS_SMALL),
  //                       color: Theme.of(context).cardColor,
  //                       boxShadow: [
  //                         BoxShadow(
  //                             color: Colors.grey[Get.isDarkMode ? 800 : 200],
  //                             spreadRadius: 1,
  //                             blurRadius: 5)
  //                       ],
  //                     ),
  //                     child: Column(children: [
  //                       Row(children: [
  //                         CodePickerWidget(
  //                           onChanged: (CountryCode countryCode) {
  //                             _countryDialCode = countryCode.dialCode;
  //                           },
  //                           initialSelection: _countryDialCode != null
  //                               ? Get.find<AuthController>()
  //                                       .getUserCountryCode()
  //                                       .isNotEmpty
  //                                   ? Get.find<AuthController>()
  //                                       .getUserCountryCode()
  //                                   : CountryCode.fromCountryCode(
  //                                           Get.find<SplashController>()
  //                                               .configModel
  //                                               .country)
  //                                       .code
  //                               : Get.find<LocalizationController>()
  //                                   .locale
  //                                   .countryCode,
  //                           favorite: [
  //                             Get.find<AuthController>()
  //                                     .getUserCountryCode()
  //                                     .isNotEmpty
  //                                 ? Get.find<AuthController>()
  //                                     .getUserCountryCode()
  //                                 : CountryCode.fromCountryCode(
  //                                         Get.find<SplashController>()
  //                                             .configModel
  //                                             .country)
  //                                     .code
  //                           ],
  //                           countryFilter: [_countryDialCode],
  //                           enabled: false,
  //                           showDropDownButton: false,
  //                           padding: EdgeInsets.zero,
  //                           showFlagMain: true,
  //                           flagWidth: 30,
  //                           dialogBackgroundColor: Theme.of(context).cardColor,
  //                           textStyle: robotoRegular.copyWith(
  //                             fontSize: Dimensions.fontSizeLarge,
  //                             color:
  //                                 Theme.of(context).textTheme.bodyText1.color,
  //                           ),
  //                         ),
  //                         Expanded(
  //                             flex: 1,
  //                             child: CustomTextField(
  //                               hintText: 'phone'.tr,
  //                               controller: _phoneController,
  //                               focusNode: _phoneFocus,
  //                               nextFocus: _passwordFocus,
  //                               inputType: TextInputType.phone,
  //                               divider: false,
  //                             )),
  //                       ]),
  //                       Padding(
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: Dimensions.PADDING_SIZE_LARGE),
  //                           child: Divider(height: 1)),
  //                       CustomTextField(
  //                         hintText: 'password'.tr,
  //                         controller: _passwordController,
  //                         focusNode: _passwordFocus,
  //                         inputAction: TextInputAction.done,
  //                         inputType: TextInputType.visiblePassword,
  //                         prefixIcon: Images.lock,
  //                         isPassword: true,
  //                         onSubmit: (text) =>
  //                             (GetPlatform.isWeb && authController.acceptTerms)
  //                                 ? _login(authController, _countryDialCode)
  //                                 : null,
  //                       ),
  //                     ]),
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(children: [
  //                     Expanded(
  //                       child: ListTile(
  //                         onTap: () => authController.toggleRememberMe(),
  //                         leading: Checkbox(
  //                           activeColor: Theme.of(context).primaryColor,
  //                           value: authController.isActiveRememberMe,
  //                           onChanged: (bool isChecked) =>
  //                               authController.toggleRememberMe(),
  //                         ),
  //                         title: Text('remember_me'.tr),
  //                         contentPadding: EdgeInsets.zero,
  //                         dense: true,
  //                         horizontalTitleGap: 0,
  //                       ),
  //                     ),
  //                     TextButton(
  //                       onPressed: () => Get.toNamed(
  //                           RouteHelper.getForgotPassRoute(false, null)),
  //                       child: Text('${'forgot_password'.tr}?'),
  //                     ),
  //                   ]),
  //                   SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
  //                   ConditionCheckBox(authController: authController),
  //                   SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
  //                   !authController.isLoading
  //                       ? Row(children: [
  //                           Expanded(
  //                               child: CustomButton(
  //                             buttonText: 'sign_up'.tr, // TODO
  //                             transparent: true,
  //                             onPressed: () =>
  //                                 Get.toNamed(RouteHelper.getSignUpRoute()),
  //                           )),
  //                           Expanded(
  //                               child: CustomButton(
  //                             buttonText: 'sign_in'.tr,
  //                             onPressed: authController.acceptTerms
  //                                 ? () =>
  //                                     _login(authController, _countryDialCode)
  //                                 : null,
  //                           )),
  //                         ])
  //                       : Center(child: CircularProgressIndicator()),
  //                   SizedBox(height: 30),
  //                   SocialLoginWidget(),
  //                   GuestButton(),
  //                 ]);
  //               }),
  //             ),
  //           ),
  //         ),
  //       ),
  //     )),
  //   );
  // }
}
