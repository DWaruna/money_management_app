import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late double width;
  static late double height;
  static late double blockHeight;
  static late double blockWidth;

  static void init(BuildContext context){
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    blockHeight = height / 100;
    blockWidth = width / 100;
  }
}