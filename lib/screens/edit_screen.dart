import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/models/constants.dart';
import 'package:get/get.dart';
class ShowData extends StatelessWidget {
  ShowData({required this.description,required this.image,required this.title ,Key? key}) : super(key: key);
  final String title;
  final String description;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff407BFF),
        title: Text(title,style: Themes.StyleOne),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null) Image.memory(base64Decode(image!),fit: BoxFit.fitHeight,),
                SizedBox(height: 15,),
                Text('Description of the Image: ',style: TextStyle(
                    fontWeight: FontWeight.w700,fontSize: 18,color: Get.isDarkMode ? Colors.white : Colors.black
                ),),
                SizedBox(height: 10,),
                Row(children: [
                  SizedBox(width: 10,),
                  Icon(Icons.arrow_forward_ios_sharp,color: Get.isDarkMode ? Colors.white : Colors.black,size: 15,),

                  Text(description,style: Themes.StyleFour,),

                ],),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
