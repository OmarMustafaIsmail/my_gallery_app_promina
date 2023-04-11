import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

Widget CustomButton(String text,SvgPicture icon, Function onPressed) {
  return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          child: Row(
            children: [
           icon,
            SizedBox(width: 3.w,),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(text,style: TextStyle(fontSize: 15.sp
              ),),
            )
          ],),
        ),
      ));
}
