import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sextconfidential/Deactivateaccscreen.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class Sidedrawer {
  static bool phonecallbool = false;
  static List<bool>switchlist=[false,false];
  static List<String> drawertitles = [
    StringConstants.phonecalls,
    StringConstants.videocalls,
    StringConstants.payoutinformation,
    StringConstants.timezone,
    StringConstants.locationdeniel,
    StringConstants.changepassword,
    StringConstants.deactivateaccount,
    StringConstants.logout,
  ];
  static List<String> drawerimages = [
    "assets/images/callunselecticon.png",
    "assets/images/videocallicon.png",
    "assets/images/payoutinfo.png",
    "assets/images/locationdenialicon.png",
    "assets/images/locationicon.png",
    "assets/images/changepassword.png",
    "assets/images/deactivateacc.png",
    "assets/images/logout.png",
  ];
  static Widget sidedrawer(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h),
        color: Appcolors().backgroundcolor,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 30.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/crossicon.png",
                        width: 5.w,
                        color: Appcolors().whitecolor,
                      ))
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 3.w,
                  right: 3.w,
                ),
                height: 12.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/btnbackgroundgradient.png"),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://c4.wallpaperflare.com/wallpaper/702/785/274/eiza-gonzalez-music-celebrities-girls-wallpaper-thumb.jpg",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 20.w,
                          alignment: Alignment.centerLeft,
                          height: 10.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Appcolors().backgroundcolor,
                            ),
                          ),
                        ),
                        // errorWidget: (context, url, error) => errorWidget,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 50.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Elexa Steele",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w500,
                                color: Appcolors().blackcolor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Appcolors().loginhintcolor,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                            child: Text(
                              StringConstants.onlinestatus + ": Off",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: "PulpDisplay",
                                  fontWeight: FontWeight.w500,
                                  color: Appcolors().bottomnavbgcolor),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Appcolors().blackcolor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(2.w),
                      child: SvgPicture.asset("assets/images/editicon.svg"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: drawertitles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      index == 4
                          ? SizedBox(
                              height: 10.h,
                            )
                          : SizedBox(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Deactivateaccscreen()));

                        },
                        child: Container(
                          height: 6.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    drawerimages.elementAt(index),
                                    height: 3.5.h,
                                    width: 3.h,
                                    color: Appcolors().whitecolor,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Container(
                                    child: Text(
                                      drawertitles.elementAt(index),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "PulpDisplay",
                                          fontWeight: FontWeight.w500,
                                          color: Appcolors().whitecolor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                ],
                              ),
                              drawertitles.elementAt(index)==StringConstants.phonecalls || drawertitles.elementAt(index)==StringConstants.videocalls?
                              Container(
                                child:FlutterSwitch(
                                  width: 60.0,
                                  height: 30.0,
                                  toggleSize: 28.0,
                                  value: switchlist.elementAt(index),
                                  borderRadius: 40.0,
                                  padding: 4.0,
                                  toggleColor: Colors.black,
                                  toggleBorder: Border.all(
                                    color: Colors.black,
                                    width: 5.0,
                                  ),
                                  activeColor: Appcolors().gradientcolorfirst,
                                  inactiveColor: Appcolors().loginhintcolor,
                                  onToggle: (val) {
                                    switchlist[index]=val;
                                  },
                                ),
                              ):
                                  SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
