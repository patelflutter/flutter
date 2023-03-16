import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final double? prefixIconSize;
  final double? suffixIconSize;
  const CustomTextFormField(
      {Key? key,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.prefixIconColor,
      this.suffixIconColor,
      this.prefixIconSize = 18,
      this.suffixIconSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2196F3)),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );
  }
}


// class CustomTextFormField extends StatelessWidget {
//   final String labelText;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final bool obscureText;

//   const CustomTextFormField({
//     required this.labelText,
//     required this.controller,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         //  labelText: 'Enter your name',
//         hintText: 'Enter your name',
//         labelStyle: TextStyle(color: Colors.grey),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.blue),
//         ),
//       ),
//     );
 
