// part of sign_in;

// class MyWidget extends GetView {


//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//           child: CountryPicker(
//               dense: false,
//               showFlag: true, //displays flag, true by default
//               showDialingCode: false, //displays dialing code, false by default
//               showName: true, //displays country name, true by default
//               showCurrency: false, //eg. 'British pound'
//               showCurrencyISO: true, //eg. 'GBP'
//               onChanged: (Country country) {
//                 country = Country.IN;
//                 // setState(() {
//                 //   _selected = country;
//                 // });
//               },
//               selectedCountry: Country.IN //  _selected,
//               ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         Expanded(
//             child: Form(
//           // key:
//           child: TextFormField(
//             // controller: controller.phoneNumber,
//             keyboardType: TextInputType.phone,
//             autofillHints: [AutofillHints.telephoneNumber],
//             validator: (value) {
//               if (value == null || value.trim() == "") return "";

//               return null;
//             },
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey)),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey)),
//                 hintText: "Phone Number)"),
//           ),
//         ))
//       ],
//     );
//   }
// }



// ////////////////////
// // /part of login_view;

// // class _PhoneNumberField extends GetView<LoginController> {
// //   const _PhoneNumberField({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
    
   

// //     return Form(
// //       key: controller.formKey,
// //       child: TextFormField(
// //         controller: controller.phoneNumber,
// //         keyboardType: TextInputType.phone,
// //         autofillHints: [AutofillHints.telephoneNumber],
// //         validator: (value) {
// //           if (value == null || value.trim() == "")
// //             return "";
// //           else if (!value.contains('+')) return "";

// //           return null;
// //         },
// //         decoration: InputDecoration(
// //             prefixIcon: Icon(
// //               Icons.phone,
// //               color: Colors.grey,
// //             ),
// //             hintText: "Phone Number(Use +91)"),
// //       ),
// //     );
// //   }
// // }