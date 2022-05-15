import 'package:flutter/material.dart';

import '../models/on_boarding_item.dart';


class SplashContent extends StatelessWidget {

  const SplashContent(this.item, {Key? key}) : super(key: key);
  final OnBoardingItem item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(item.title!,style:
          const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xff407BFF)),),
          Text(item.description!,style:  const TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
          SizedBox(height: 25,),
          Image.asset(item.image,height: MediaQuery.of(context).size.height*0.4,),
        ],
      ),
    );
  }
}