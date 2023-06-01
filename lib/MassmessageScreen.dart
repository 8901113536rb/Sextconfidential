import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sextconfidential/Bottomnavigation.dart';
import 'package:sextconfidential/Videoscreen.dart';
import 'package:sextconfidential/main.dart';
import 'package:sextconfidential/pojo/massmassagespojo.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
import 'package:sextconfidential/utils/Helpingwidgets.dart';
import 'package:sextconfidential/utils/Networks.dart';
import 'package:sextconfidential/utils/Progressdialog.dart';
import 'package:sextconfidential/utils/Sidedrawer.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import 'LoginScreen.dart';

class MassmessageScreen extends StatefulWidget {
  @override
  MassmessageScreenState createState() => MassmessageScreenState();
}

class MassmessageScreenState extends State<MassmessageScreen> {
  List<String> massmessagetype = [
    "All Available",
    "Favourites",
    "Create New group"
  ];
  String dropdownvalue = "All Available";
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  List<String> messagehistorytype = [
    StringConstants.mostrecent,
    StringConstants.mostsends,
    StringConstants.mostread,
    StringConstants.readrate,
    StringConstants.mostunlocks,
    StringConstants.mostearnings,
  ];
  Massmassagespojo? massmassagespojo;
  String? token;
  String messagehistoryvalue = "Most Recent";
  TextEditingController messagecontroller = TextEditingController();
  TextEditingController searchclientcontroller = TextEditingController();
  TextEditingController groupnamecontroller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;
  late final VideoPlayerController videoPlayerController;
  int imagecredit = 1;
  File? imageFile;
  bool videostatus = false;
  Uint8List? thumbnail;
  List<int> groupusers = [];
  GlobalKey<State> key = GlobalKey();
  GlobalKey<FormState> formkey = GlobalKey();
  bool responsestatus = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsharedpreference();
    // startvideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      drawer: Sidedrawer(),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Appcolors().bottomnavbgcolor,
      //   leading: GestureDetector(
      //     onTap: (){
      //       _key.currentState!.openDrawer();
      //     },
      //       child: Center(child: SvgPicture.asset("assets/images/menubtn.svg",))),
      //   title: Text(StringConstants.massmessages,style: TextStyle(
      //       fontSize: 14.sp,
      //       fontFamily: "PulpDisplay",
      //       fontWeight: FontWeight.w500,
      //       color: Appcolors().whitecolor),),
      // ),
      body: Container(
        padding: EdgeInsets.only(left: 3.w, right: 3.w),
        color: Appcolors().backgroundcolor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            StringConstants.sendmassmessageto,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w400,
                                color: Appcolors().whitecolor),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Container(
                            width: 45.w,
                            child: CustomDropdownButton2(
                              hint: "Select Item",
                              dropdownItems: massmessagetype,
                              value: dropdownvalue,
                              dropdownWidth: 45.w,
                              dropdownHeight: 60.h,
                              buttonWidth: 27.w,
                              onChanged: (value) {
                                setState(() {
                                  if (value == "Create New group") {
                                    createnewgroup(context);
                                  }
                                  dropdownvalue = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: TextFormField(
                          minLines: 3,
                          maxLines: 3,
                          cursorColor: Appcolors().loginhintcolor,
                          style: TextStyle(
                            color: Appcolors().whitecolor,
                            fontSize: 12.sp,
                          ),
                          controller: messagecontroller,
                          decoration: InputDecoration(
                            // prefix: Container(
                            //   child: SvgPicture.asset("assets/images/astrickicon.svg",width: 5.w,),
                            // ),
                            border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Appcolors().logintextformborder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Appcolors().logintextformborder),
                            ),
                            filled: true,
                            isDense: true,
                            fillColor: Appcolors().messageboxbgcolor,
                            hintText: StringConstants.whatareyouupto,
                            hintStyle: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              // fontFamily: 'PulpDisplay',
                              color: Appcolors().loginhintcolor,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Message";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          child: DottedBorder(
                            strokeCap: StrokeCap.round,
                            strokeWidth: 1,
                            dashPattern: [8, 4],
                            color: Appcolors().gradientcolorfirst,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            padding: EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: imageFile == null
                                  ? GestureDetector(
                                      onTap: () {
                                        addmediadialog(context);
                                      },
                                      child: Container(
                                          height: 5.h,
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: SvgPicture.asset(
                                                "assets/images/uploadimageicon.svg",
                                                height: 3.h,
                                                width: 3.w,
                                              )),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                StringConstants
                                                    .addphotosorvideo,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    // fontFamily: "PulpDisplay",
                                                    fontWeight: FontWeight.w500,
                                                    color: Appcolors()
                                                        .loginhintcolor),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                          // color: Colors.amber,
                                          ),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                // child: Image.file(imageFile!,height:15.h,width:25.w,fit: BoxFit.fill,)),
                                                child: imageFile!.path.substring(
                                                            imageFile!.path
                                                                    .length -
                                                                3,
                                                            imageFile!
                                                                .path.length) ==
                                                        "mp4"
                                                    ? Image.memory(
                                                        thumbnail!,
                                                        height: 15.h,
                                                        width: 25.w,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        imageFile!,
                                                        height: 15.h,
                                                        width: 25.w,
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    imageFile = null;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: 1.h,
                                                  backgroundColor: Colors.white,
                                                  child: Image.asset(
                                                    "assets/images/crossicon.png",
                                                    height: 1.h,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 4.h,
                                              alignment: Alignment.center,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Appcolors()
                                                          .loginhintcolor),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                imagecredit.toString(),
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontFamily: "PulpDisplay",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Appcolors().whitecolor),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (imagecredit > 1) {
                                                    imagecredit =
                                                        imagecredit - 1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    right: 20.w),
                                                alignment: Alignment.center,
                                                width: 4.w,
                                                height: 2.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontSize: 8.sp,
                                                      fontFamily: "PulpDisplay",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Appcolors()
                                                          .blackcolor),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  imagecredit = imagecredit + 1;
                                                });
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 20.w),
                                                alignment: Alignment.center,
                                                width: 4.w,
                                                height: 2.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/btnbackgroundgradient.png"),
                                                        fit: BoxFit.fill),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      fontSize: 8.sp,
                                                      fontFamily: "PulpDisplay",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Appcolors()
                                                          .blackcolor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            massmessages();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/btnbackgroundgradient.png"),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                          height: 5.h,
                          child: Text(
                            StringConstants.send,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w400,
                                color: Appcolors().backgroundcolor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Container(
                        width: 45.w,
                        child: CustomDropdownButton2(
                          hint: "Select Item",
                          dropdownItems: messagehistorytype,
                          value: messagehistoryvalue,
                          dropdownWidth: 45.w,
                          dropdownHeight: 60.h,
                          buttonWidth: 27.w,
                          onChanged: (value) {
                            setState(() {
                              messagehistoryvalue = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      responsestatus
                          ? AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: massmassagespojo!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Column(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(2.h),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Appcolors()
                                                            .chatuserborder),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.h)),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    massmassagespojo!.data!
                                                                .elementAt(
                                                                    index)
                                                                .messageType ==
                                                            "jpg"
                                                        ? Column(
                                                            children: [
                                                              Container(
                                                                width: 40.w,
                                                                height: 20.h,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: massmassagespojo!
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .message
                                                                      .toString(),
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    width: 15.w,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    height:
                                                                        4.5.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            2,
                                                                        color: Appcolors()
                                                                            .backgroundcolor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // errorWidget: (context, url, error) => errorWidget,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2.h,
                                                              ),
                                                            ],
                                                          )
                                                        : massmassagespojo!
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .messageType ==
                                                                "mp4"
                                                            ? Column(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () {
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Videoscreen(videopath: massmassagespojo!
                                                                            .data!
                                                                            .elementAt(
                                                                            index)
                                                                            .message.toString(),)));
                                                                        },
                                                                    child: Container(
                                                                        width: 40
                                                                            .w,
                                                                        height: 20
                                                                            .h,
                                                                        child: Image.asset(
                                                                            "assets/images/thumbnaildefault.png")),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(
                                                                decoration: BoxDecoration(
                                                                    color: Appcolors()
                                                                        .loginhintcolor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            1.5.h)),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            3.w,
                                                                        right:
                                                                            3.w,
                                                                        top: 1.5
                                                                            .h,
                                                                        bottom:
                                                                            1.5.h),
                                                                child: Text(
                                                                  massmassagespojo!
                                                                      .data!
                                                                      .elementAt(
                                                                          index)
                                                                      .message
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontFamily:
                                                                          "PulpDisplay",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Appcolors()
                                                                          .backgroundcolor),
                                                                ),
                                                              ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        StringConstants.sent +
                                                            massmassagespojo!
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .time
                                                                .toString(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          // fontFamily: "PulpDisplay",
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Appcolors()
                                                              .loginhintcolor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Divider(
                                                        thickness: 1.2,
                                                        height: 1.h,
                                                        color: Appcolors()
                                                            .dividercolor),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 0.5.h,
                                                            ),
                                                            Container(
                                                              child:
                                                                  GradientText(
                                                                massmassagespojo!
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .total
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontFamily:
                                                                        "PulpDisplay",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                gradientType:
                                                                    GradientType
                                                                        .linear,
                                                                gradientDirection:
                                                                    GradientDirection
                                                                        .ttb,
                                                                radius: 8,
                                                                colors: [
                                                                  Appcolors()
                                                                      .gradientcolorfirst,
                                                                  Appcolors()
                                                                      .gradientcolorsecond,
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                StringConstants
                                                                    .sent,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontFamily:
                                                                      "PulpDisplay",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Appcolors()
                                                                      .loginhintcolor,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                            height: 6.h,
                                                            width: 1.5,
                                                            color: Appcolors()
                                                                .dividercolor),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 0.5.h,
                                                            ),
                                                            Container(
                                                              child:
                                                                  GradientText(
                                                                massmassagespojo!
                                                                    .data!
                                                                    .elementAt(
                                                                        index)
                                                                    .seen
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontFamily:
                                                                        "PulpDisplay",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                gradientType:
                                                                    GradientType
                                                                        .linear,
                                                                gradientDirection:
                                                                    GradientDirection
                                                                        .ttb,
                                                                radius: 6,
                                                                colors: [
                                                                  Appcolors()
                                                                      .gradientcolorfirst,
                                                                  Appcolors()
                                                                      .gradientcolorsecond,
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                StringConstants
                                                                    .reads,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontFamily:
                                                                      "PulpDisplay",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Appcolors()
                                                                      .loginhintcolor,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                            height: 6.h,
                                                            width: 1.5,
                                                            color: Appcolors()
                                                                .dividercolor),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 0.5.h,
                                                            ),
                                                            Container(
                                                              child:
                                                                  GradientText(
                                                                massmassagespojo!
                                                                        .data!
                                                                        .elementAt(
                                                                            index)
                                                                        .percentage
                                                                        .toString() +
                                                                    "%",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontFamily:
                                                                        "PulpDisplay",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                gradientType:
                                                                    GradientType
                                                                        .linear,
                                                                gradientDirection:
                                                                    GradientDirection
                                                                        .ttb,
                                                                radius: 6,
                                                                colors: [
                                                                  Appcolors()
                                                                      .gradientcolorfirst,
                                                                  Appcolors()
                                                                      .gradientcolorsecond,
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                StringConstants
                                                                    .readrate,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontFamily:
                                                                      "PulpDisplay",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Appcolors()
                                                                      .loginhintcolor,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Helpingwidgets().customloader()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> videoplayer(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Appcolors().blackcolor,
            //title: Text("Image Picker"),
            content: StatefulBuilder(
              // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                    alignment: Alignment.center,
                    height: 50.h,
                    width: 80.h,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                            width: 80.h,
                            color: Colors.black,
                            height:
                                (MediaQuery.of(context).size.height / 100) * 50,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: CustomVideoPlayer(
                                customVideoPlayerController:
                                    _customVideoPlayerController,
                              ),
                              // VideoPlayer(
                              //     _controller),
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5.w, top: 1.h),
                            height: 4.h,
                            width: 4.w,
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              "assets/images/crossicon.png",
                              color: Colors.white,
                              height: 4.h,
                              width: 4.w,
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            ),
          );
        });
  }

  Future<void> addmediadialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Colors.transparent,
            //title: Text("Image Picker"),
            content: StatefulBuilder(
              // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 80.w,
                        // margin: EdgeInsets.only(left: 2.w, right: 2.w,bottom: 1.h),
                        alignment: Alignment.center,
                        height: 10.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/btnbackgroundgradient.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _getFromGallery();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/documentupload.svg",
                                    height: 3.h,
                                    width: 3.w,
                                    color: Appcolors().bottomnavbgcolor,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    StringConstants.choosefile,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        // fontFamily: "PulpDisplay",
                                        fontWeight: FontWeight.w500,
                                        color: Appcolors().bottomnavbgcolor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                clickphotofromcamera();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/cameraicon.svg",
                                    height: 3.h,
                                    width: 3.w,
                                    color: Appcolors().bottomnavbgcolor,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    StringConstants.takephoto,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        // fontFamily: "PulpDisplay",
                                        fontWeight: FontWeight.w500,
                                        color: Appcolors().bottomnavbgcolor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                pickVideo();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/videoicon.svg",
                                    height: 3.h,
                                    width: 3.w,
                                    color: Appcolors().bottomnavbgcolor,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    StringConstants.recordvideo,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        // fontFamily: "PulpDisplay",
                                        fontWeight: FontWeight.w500,
                                        color: Appcolors().bottomnavbgcolor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 1.5.h,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          "assets/images/crossicon.png",
                          height: 1.5.h,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  Future<void> createnewgroup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Appcolors().backgroundcolor,
            // contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            //title: Text("Image Picker"),
            content: StatefulBuilder(
              // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                    width: 90.w,
                    // margin: EdgeInsets.only(left: 2.w, right: 2.w,bottom: 1.h),
                    alignment: Alignment.center,
                    height: 80.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  StringConstants.createagroup,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "PulpDisplay",
                                    fontWeight: FontWeight.w400,
                                    color: Appcolors().whitecolor,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              // SvgPicture.asset(
                              //   "assets/images/searchicon.svg",
                              //   color: Colors.white,
                              // )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 1.5.h),
                            child: TextFormField(
                              cursorColor: Appcolors().loginhintcolor,
                              style: TextStyle(
                                color: Appcolors().whitecolor,
                                fontSize: 12.sp,
                              ),
                              controller: groupnamecontroller,
                              decoration: InputDecoration(
                                // prefix: Container(
                                //   child: SvgPicture.asset("assets/images/astrickicon.svg",width: 5.w,),
                                // ),
                                border: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Appcolors().logintextformborder),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Appcolors().logintextformborder),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Appcolors().logintextformborder),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Appcolors().logintextformborder),
                                ),
                                isDense: true,
                                filled: true,
                                fillColor: Appcolors().backgroundcolor,
                                hintText: StringConstants.enteryourgroupname,
                                hintStyle: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  // fontFamily: 'PulpDisplay',
                                  color: Appcolors().loginhintcolor,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 1.5.h),
                            // padding: EdgeInsets.only(top: 1.h,bottom: 1.h),
                            child: TextFormField(
                              cursorColor: Appcolors().loginhintcolor,
                              style: TextStyle(
                                color: Appcolors().whitecolor,
                                fontSize: 12.sp,
                              ),
                              controller: searchclientcontroller,
                              decoration: InputDecoration(
                                // prefix: SvgPicture.asset("assets/images/searchicon.svg",color: Colors.white,width: 4.w,),
                                isDense: true,
                                border: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Appcolors().logintextformborder),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Appcolors().logintextformborder),
                                ),
                                filled: true,
                                fillColor: Appcolors().backgroundcolor,
                                hintText: StringConstants.searchclients,
                                hintStyle: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  // fontFamily: 'PulpDisplay',
                                  color: Appcolors().loginhintcolor,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 47.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        height: 5.h,
                                        padding: EdgeInsets.only(
                                            left: 2.w, right: 2.w),
                                        decoration: BoxDecoration(
                                            color: groupusers.contains(index)
                                                ? Appcolors().selectedusercolor
                                                : Colors.transparent,
                                            border: Border.all(
                                                color:
                                                    Appcolors().chatuserborder),
                                            borderRadius:
                                                BorderRadius.circular(1.5.h)),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rohit",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "PulpDisplay",
                                                  fontWeight: FontWeight.w400,
                                                  color: groupusers
                                                          .contains(index)
                                                      ? Appcolors()
                                                          .bottomnavbgcolor
                                                      : Appcolors().whitecolor),
                                              textAlign: TextAlign.center,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (groupusers
                                                        .contains(index)) {
                                                      groupusers.remove(index);
                                                    } else {
                                                      groupusers.add(index);
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  groupusers.contains(index)
                                                      ? Icons.close_sharp
                                                      : Icons.add,
                                                  color:
                                                      groupusers.contains(index)
                                                          ? Appcolors()
                                                              .bottomnavbgcolor
                                                          : Colors.white,
                                                ))
                                          ],
                                        )),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/btnbackgroundgradient.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(10)),
                            height: 5.h,
                            child: Text(
                              StringConstants.creategroup,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "PulpDisplay",
                                  fontWeight: FontWeight.w400,
                                  color: Appcolors().backgroundcolor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 5.h,
                              child: Text(
                                StringConstants.close,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "PulpDisplay",
                                    fontWeight: FontWeight.w400,
                                    color: Appcolors().whitecolor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          );
        });
  }

  void startvideo() {
    videoPlayerController = VideoPlayerController.network(
        "https://coderzbar.info/dev/worldofquotes_dev/storage/app/public/author/498330079authorimage.mp4")
      ..initialize().then((value) => setState(() {
            print("Video working");
            var durationOfVideo =
                videoPlayerController.value.position.inSeconds.round();
            print("Duration of video:-" + durationOfVideo.toString());
            debugPrint("========" + _controller.value.duration.toString());
          }));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );

    _controller = VideoPlayerController.network(
        "https://coderzbar.info/dev/worldofquotes_dev/storage/app/public/author/498330079authorimage.mp4")
      ..initialize().then(
        (_) {
          debugPrint("========" + _controller.value.duration.toString());
          print("Video Started");
          setState(() {
            videostatus = true;
          });
          var durationOfVideo =
              videoPlayerController.value.position.inSeconds.round();
          print("Duration of videos:-" + durationOfVideo.toString());
        },
      );
  }

  _getFromGallery() async {
    Navigator.pop(context);
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  clickphotofromcamera() async {
    Navigator.pop(context);
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> pickVideo() async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print("Video path:-${imageFile?.path}");
      createthumbnail();
      // print("Video path:-${pickedFile.path}");
    }
    return null;
  }

  Future<void> createthumbnail() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: imageFile!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    setState(() {
      thumbnail = uint8list;
    });
  }

  Future<void> getsharedpreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("token");
    });
    print("Token value:-" + token.toString());
    massmessageslisting();
  }

  Future<void> massmessageslisting() async {
    Map data = {
      "token": token,
    };
    print("Data:-" + data.toString());
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse(Networks.baseurl + Networks.massmessagedetail),
        body: data);
    jsonResponse = json.decode(response.body);
    print("jsonResponse:-" + jsonResponse.toString());
    if (response.statusCode == 200) {
      if (jsonResponse["status"] == false) {
        setState(() {
          responsestatus = true;
        });
        Helpingwidgets.failedsnackbar(
            jsonResponse["message"].toString(), context);
        Navigator.pop(context);
      } else {
        setState(() {
          responsestatus = true;
        });
        Helpingwidgets.successsnackbar(
            jsonResponse["message"].toString(), context);
        print("Response:${jsonResponse["message"]}");
        massmassagespojo = Massmassagespojo.fromJson(jsonResponse);
      }
    } else {
      setState(() {
        responsestatus = true;
      });
      Helpingwidgets.failedsnackbar(
          jsonResponse["message"].toString(), context);
    }
  }

  Future<void> massmessages() async {
    Helpingwidgets.showLoadingDialog(context, key);
    var request = http.MultipartRequest(
      'post',
      Uri.parse(Networks.baseurl + Networks.massmessage),
    );
    var jsonData = null;
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["text"] = messagecontroller.text.trim();
    request.fields["token"] = token!;
    print("token:-" + token!);
    print("Message:-" + messagecontroller.text.trim());
    print("token:-" + token.toString());
    // print("Image path:-"+imageFile!.path.toString());
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath("file", imageFile!.path,
            filename: imageFile!.path),
      );
    }
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      jsonData = json.decode(value);
      print("Json:-" + jsonData.toString());
      if (response.statusCode == 200) {
        if (jsonData["status"] == false) {
          Helpingwidgets.failedsnackbar(
              jsonData["message"].toString(), context);
          print("Response:${jsonData["message"]}");
          Navigator.pop(context);
        } else {
          messagecontroller.clear();
          Helpingwidgets.successsnackbar(
              jsonData["message"].toString(), context);
          print("Response:${jsonData["message"]}");
          Navigator.pop(context);
        }
      } else {
        Helpingwidgets.failedsnackbar(jsonData["message"].toString(), context);
        print("Response:${jsonData["message"]}");
        Navigator.pop(context);
      }
    });
  }
}
