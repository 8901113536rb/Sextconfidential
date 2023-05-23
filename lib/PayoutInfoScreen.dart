import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class PayoutInfoScreen extends StatefulWidget {
  @override
  PayoutInfoScreenState createState() => PayoutInfoScreenState();
}

class PayoutInfoScreenState extends State<PayoutInfoScreen> {
  bool twelvehouralert = false;
  bool endofpayalert = false;
  bool payoutprocessedalert = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors().backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolors().bottomnavbgcolor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            print("Click back");
          },
          child: Container(
              // color: Colors.white,
              margin: EdgeInsets.only(left: 2.w),
              child: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        title: Text(
          StringConstants.payoutinformation,
          style: TextStyle(
              fontSize: 14.sp,
              fontFamily: "PulpDisplay",
              fontWeight: FontWeight.w500,
              color: Appcolors().whitecolor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 3.w, right: 3.w),
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: twelvehouralert
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              colors: [
                                Appcolors().gradientcolorfirst,
                                Appcolors().gradientcolorsecond,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Appcolors().checkboxcolor,
                        ),
                  height: 3.h,
                  width: 3.h,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    checkColor: Appcolors().backgroundcolor,
                    activeColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    value: twelvehouralert,
                    onChanged: (value) {
                      setState(() {
                        twelvehouralert = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                twelvehouralert
                    ? GradientText(
                  StringConstants.hoursalert,
                  style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w500,
                      color: Appcolors().loginhintcolor),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: 8,
                  colors: [
                    Appcolors().gradientcolorfirst,
                    Appcolors().gradientcolorsecond,
                  ],
                )
                    : Text(
                  StringConstants.hoursalert,
                  style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w500,
                      color: Appcolors().loginhintcolor),
                )
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: payoutprocessedalert
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              colors: [
                                Appcolors().gradientcolorfirst,
                                Appcolors().gradientcolorsecond,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Appcolors().checkboxcolor,
                        ),
                  height: 3.h,
                  width: 3.h,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    checkColor: Appcolors().backgroundcolor,
                    activeColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    value: payoutprocessedalert,
                    onChanged: (value) {
                      setState(() {
                        payoutprocessedalert = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                payoutprocessedalert
                    ? GradientText(
                  StringConstants.payoutprocessed,
                  style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w500,
                      color: Appcolors().loginhintcolor),
                  gradientType: GradientType.linear,
                  gradientDirection: GradientDirection.ttb,
                  radius: 8,
                  colors: [
                    Appcolors().gradientcolorfirst,
                    Appcolors().gradientcolorsecond,
                  ],
                )
                    : Text(
                  StringConstants.payoutprocessed,
                  style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w500,
                      color: Appcolors().loginhintcolor),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: endofpayalert
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              colors: [
                                Appcolors().gradientcolorfirst,
                                Appcolors().gradientcolorsecond,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Appcolors().checkboxcolor,
                        ),
                  height: 3.h,
                  width: 3.h,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    checkColor: Appcolors().backgroundcolor,
                    activeColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    value: endofpayalert,
                    onChanged: (value) {
                      setState(() {
                        endofpayalert = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                endofpayalert
                    ? GradientText(
                        StringConstants.endofpayperiod,
                        style: TextStyle(
                            fontSize: 12.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w500,
                            color: Appcolors().loginhintcolor),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ttb,
                        radius: 8,
                        colors: [
                          Appcolors().gradientcolorfirst,
                          Appcolors().gradientcolorsecond,
                        ],
                      )
                    : Text(
                        StringConstants.endofpayperiod,
                        style: TextStyle(
                            fontSize: 12.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w500,
                            color: Appcolors().loginhintcolor),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
