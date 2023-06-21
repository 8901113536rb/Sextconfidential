import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

import 'Appcolors.dart';

class Helpingwidgets{
  Widget customloader(){
    return Container(
      height: 10.h,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          size: 50, color: Appcolors().gradientcolorfirst,
        ),
      ),
    );
  }

  static void successsnackbar(String content,BuildContext context){
    var snackbar = SnackBar(
        backgroundColor: Appcolors().bottomnavbgcolor,
        content: Text(content,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),));
    ScaffoldMessenger.of(context)
        .showSnackBar(snackbar);
  }
  static void failedsnackbar(String content,BuildContext context){
    var snackbar = SnackBar(
        backgroundColor: Appcolors().bottomnavbgcolor,
        content: Text(content,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,color:Colors.red),));
    ScaffoldMessenger.of(context)
        .showSnackBar(snackbar);
  }
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        size: 50, color: Appcolors().gradientcolorfirst,
                      ),
                    )
                  ]));
        });
  }
  static Widget emptydata(String message) {
    return Container(
      alignment: Alignment.center,
      height: 20.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Divider(thickness: 1.2, height: 1.h, color: Appcolors().dividercolor),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/noresponse.png",
                height: 5.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              GradientText(
                message,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "PulpDisplay",
                    fontWeight: FontWeight.w400),
                gradientType: GradientType.linear,
                gradientDirection: GradientDirection.ttb,
                radius: 6,
                colors: [
                  Appcolors().gradientcolorfirst,
                  Appcolors().gradientcolorsecond,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  static Widget emptydatawithoutdivider(String message) {
    return Container(
      alignment: Alignment.center,
      height: 20.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/noresponse.png",
                height: 5.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              GradientText(
                message,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "PulpDisplay",
                    fontWeight: FontWeight.w400),
                gradientType: GradientType.linear,
                gradientDirection: GradientDirection.ttb,
                radius: 6,
                colors: [
                  Appcolors().gradientcolorfirst,
                  Appcolors().gradientcolorsecond,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}