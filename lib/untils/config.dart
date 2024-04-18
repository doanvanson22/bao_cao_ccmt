// set constant config here
import 'package:flutter/material.dart';

class Config{
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  // width and height initialization// khởi tạo chiều rộng và chiều cao
  void init(BuildContext context){
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize{
    return screenWidth;
  }

  static get heightSize{
    return screenHeight;
  }

  //define spacing hegiht//xác định chiều cao khoảng cách
  static const spaceSmall = SizedBox(height: 25,);
  static final spaceMedium = SizedBox(height: screenHeight! *0.05,);
  static final spaceBig = SizedBox(height: screenHeight! *0.08,);

  // textform field border// viền trường văn bản
  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8),)
  );

  static const focusBorder =  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.blueAccent,
    )
  );

  static const errorBorder =  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.red,
    )
  );

  static const primaryColor = Colors.blueAccent;
}