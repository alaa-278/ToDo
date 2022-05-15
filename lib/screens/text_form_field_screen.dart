import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      this.validator,
      required this.labelText,
      this.onSaved,
      this.controller})
      : super(key: key);
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onSaved: widget.onSaved,
      cursorColor: Get.isDarkMode?Colors.black:Colors.white,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: new TextStyle( color:Get.isDarkMode?Colors.black:Colors.white, fontSize: 15),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Get.isDarkMode?Colors.black:Colors.white,),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Get.isDarkMode?Colors.black:Colors.white),
        ),
      ),
    );
  }
}
