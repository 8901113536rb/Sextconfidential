import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sextconfidential/Changepassword.dart';
import 'package:sextconfidential/Deactivateaccscreen.dart';
import 'package:sextconfidential/Editprofilescreen.dart';
import 'package:sextconfidential/LoginScreen.dart';
import 'package:sextconfidential/PayoutInfoScreen.dart';
import 'package:sextconfidential/TimezoneScreen.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class Sidedrawer extends StatefulWidget {
  @override
  SidedrawerState createState() => SidedrawerState();
}

class SidedrawerState extends State<Sidedrawer> {
  static bool phonecallbool = false;
  static List<bool> switchlist = [false, false];
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
  int onlinestatus = 0;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors().backgroundcolor,
      body: SafeArea(
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
                        child: Container(
                          margin: EdgeInsets.only(right: 0.5.w,top: 0.5.h),
                          child: Image.asset(
                            "assets/images/crossicon.png",
                            width: 5.w,
                            color: Appcolors().whitecolor,
                          ),
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
                            InkWell(
                              onTap: (){
                                setState(() {
                                  onlinestatus==0?
                                      onlinestatus=1
                                      :onlinestatus==1?
                                      onlinestatus=2
                                      :onlinestatus=0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: onlinestatus==0?Appcolors().loginhintcolor : onlinestatus == 1?Appcolors().onlinecolor :Appcolors().deactivatecolor,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.only(
                                    left: 3.w,
                                    right: 3.w,
                                    top: 1.h,
                                    bottom: 1.h),
                                child: Text(
                                  onlinestatus == 0
                                      ? StringConstants.onlinestatus + ": Off"
                                      : onlinestatus == 1
                                          ? StringConstants.onlinestatus +
                                              ": On"
                                          : StringConstants.onlinestatus +
                                              ": Away",
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      fontFamily: "PulpDisplay",
                                      fontWeight: FontWeight.w500,
                                      color: onlinestatus==2?Appcolors().whitecolor:Appcolors().bottomnavbgcolor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Editprofilescreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Appcolors().blackcolor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(2.w),
                          child: SvgPicture.asset("assets/images/editicon.svg"),
                        ),
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
                        index == 5
                            ? SizedBox(
                                height: 12.h,
                              )
                            : SizedBox(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              switch(index){
                                case 2: Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PayoutInfoScreen()));
                                break;
                                case 3:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TimezoneScreen()));
                                  break;
                                  case 4:

                                  break;
                                case 5:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Changepassword()));
                                  break;
                                  case 6:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Deactivateaccscreen()));
                                  break;
                                case 6:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()));
                              }
                            });

                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 4.w),
                            height: 6.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      drawerimages.elementAt(index),
                                      height: 2.5.h,
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
                                drawertitles.elementAt(index) ==
                                            StringConstants.phonecalls ||
                                        drawertitles.elementAt(index) ==
                                            StringConstants.videocalls
                                    ? Container(
                                        child: FlutterSwitch(
                                          width: 50.0,
                                          height: 25.0,
                                          toggleSize: 25.0,
                                          value: switchlist.elementAt(index),
                                          borderRadius: 40.0,
                                          padding: 2.0,
                                          toggleColor: Colors.black,
                                          toggleBorder: Border.all(
                                            color: Colors.black,
                                            width: 5.0,
                                          ),
                                          activeColor:
                                              Appcolors().gradientcolorfirst,
                                          inactiveColor:
                                              Appcolors().loginhintcolor,
                                          onToggle: (val) {
                                            setState(() {
                                              switchlist[index] = val;
                                            });
                                          },
                                        ),
                                      )
                                    : SizedBox()
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
      ),
    );
  }
}
