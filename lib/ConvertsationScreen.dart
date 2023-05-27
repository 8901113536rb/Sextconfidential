import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sextconfidential/UserprofileScreen.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

class ConvertsationScreen extends StatefulWidget {
  @override
  ConvertsationScreenState createState() => ConvertsationScreenState();
}

class ConvertsationScreenState extends State<ConvertsationScreen> {
  TextEditingController messagecontroller = TextEditingController();
  bool showuploaddialog = false;
  bool emojiShowing = false;
  File? imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (emojiShowing == true) {
          setState(() {
            emojiShowing = false;
            showuploaddialog = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
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
          leadingWidth: 7.w,
          title: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserprofileScreen()));
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 5.h,
                        width: 16.w,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://c4.wallpaperflare.com/wallpaper/702/785/274/eiza-gonzalez-music-celebrities-girls-wallpaper-thumb.jpg",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 16.w,
                            alignment: Alignment.centerLeft,
                            height: 5.h,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Elexa Steele",
                            style: TextStyle(
                                fontSize: 12.sp,
                                // fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w500,
                                color: Appcolors().whitecolor),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            StringConstants.onlinenow,
                            style: TextStyle(
                                fontSize: 8.sp,
                                // fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w400,
                                color: Appcolors().onlinecolor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            // padding: EdgeInsets.only(left: 2.w, right: 2.w),
            color: Appcolors().backgroundcolor,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      AnimationLimiter(
                        child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showuploaddialog = false;
                                        emojiShowing = false;
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 2.w, right: 2.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              daydivider(),
                                              sendermessage(index),
                                              receivermessage(index),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    showuploaddialog ? uploadcontainer() : SizedBox(),
                    Container(
                      margin: EdgeInsets.only(left: 2.w, right: 2.w),
                      color: Appcolors().backgroundcolor,
                      width: double.infinity,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 1.h),
                        padding: EdgeInsets.only(
                          left: 2.w,
                          right: 2.w,
                          top: 1.h,
                          bottom: 1.h,
                        ),
                        decoration: BoxDecoration(
                            color: Appcolors().bottomnavbgcolor,
                            borderRadius: BorderRadius.circular(15)),
                        // height: 7.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  emojiShowing = !emojiShowing;
                                });
                              },
                              child: SvgPicture.asset(
                                "assets/images/emojiimg.svg",
                                height: 3.h,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                cursorColor: Appcolors().loginhintcolor,
                                style: TextStyle(
                                  color: Appcolors().loginhintcolor,
                                  fontSize: 12.sp,
                                ),
                                controller: messagecontroller,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  // focusedBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: Appcolors().bottomnavbgcolor,
                                  hintText: StringConstants.type,
                                  hintStyle: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    // fontFamily: 'PulpDisplay',
                                    color: Appcolors().loginhintcolor,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    emojiShowing = false;
                                    showuploaddialog = false;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Please enter Message";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: SocialMediaRecorder(
                            //     sendRequestFunction: (soundFile) {
                            //       print("the current path is ${soundFile.path}");
                            //     },
                            //     encode: AudioEncoderType.AAC,
                            //   ),
                            // ),
                            SvgPicture.asset(
                              "assets/images/micicon.svg",
                              height: 2.5.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (showuploaddialog) {
                                      showuploaddialog = false;
                                    } else {
                                      showuploaddialog = true;
                                      emojiShowing = false;
                                    }
                                  });
                                },
                                child: SvgPicture.asset(
                                  "assets/images/cameraicon.svg",
                                  height: 2.5.h,
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              "assets/images/sendicon.svg",
                              height: 2.5.h,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !emojiShowing,
                      child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            textEditingController: messagecontroller,
                            config: Config(
                              columns: 7,
                              // Issue: https://github.com/flutter/flutter/issues/28894
                              emojiSizeMax: 32 *
                                  (foundation.defaultTargetPlatform ==
                                          TargetPlatform.iOS
                                      ? 1.30
                                      : 1.0),
                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor:Appcolors().backgroundcolor,
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Appcolors().backgroundcolor,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              showRecentsTab: true,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: const Text(
                                'No Recents',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: const SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: const CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadcontainer() {
    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w,bottom: 1.h),
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
            onTap: (){
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
            onTap: (){
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
            onTap: (){
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
    );
  }

  Widget sendermessage(int index) {
    return Column(
      children: [
        // SizedBox(
        //   height: 2.h,
        // ),
        Container(
          margin: EdgeInsets.only(left: 2.w, right: 2.w),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 15.h,
                width: 40.w,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://images.squarespace-cdn.com/content/v1/53cc306ee4b04fd213249899/1657760960280-QKY0G0PHGZBAW4T3K5T9/Boudoir+Photo+Shoot+Salem+Oregon+Boudoir+Photographer.jpg",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 15.h,
                    width: 40.w,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
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
                height: 0.5.h,
              ),
              Text(
                "Sent for \$10.00 at 03:08AM",
                style: TextStyle(
                    fontSize: 8.sp,
                    fontFamily: "PulpDisplay",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Appcolors().loginhintcolor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 2.w, right: 2.w),
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(1.5.h),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/btnbackgroundgradient.png",
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  index % 2 == 0 ? "I’m on the highway" : "OK",
                  style: TextStyle(
                      fontSize: 11.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w500,
                      color: Appcolors().blackcolor),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                "Sent 01:30 am",
                style: TextStyle(
                    fontSize: 11.sp,
                    // fontFamily: "PulpDisplay",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Appcolors().loginhintcolor),
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget receivermessage(int index) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                // alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 6.w),
                padding: EdgeInsets.only(
                    right: 4.w, left: 8.w, top: 2.h, bottom: 2.h),
                decoration: BoxDecoration(
                  color: Appcolors().profileboxcolor,
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
                // height: 7.h,
                // width: 80.w,
                child: Text(
                  index % 2 == 0
                      ? "Let me know when you are available baby"
                      : "We should video chat now baby",
                  style: TextStyle(
                      fontSize: 11.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w500,
                      // fontStyle: FontStyle.italic,
                      color: Appcolors().whitecolor),
                ),
              ),
              Container(
                height: 6.h,
                width: 11.w,
                padding: EdgeInsets.all(0.6.h),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Appcolors().backgroundcolor),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://c4.wallpaperflare.com/wallpaper/702/785/274/eiza-gonzalez-music-celebrities-girls-wallpaper-thumb.jpg",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 10.w,
                    alignment: Alignment.centerLeft,
                    height: 6.h,
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
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, top: 0.5.h),
          width: double.infinity,
          // alignment: Alignment.centerLeft,
          child: Text(
            "Sent 01:30 am",
            style: TextStyle(
                fontSize: 11.sp,
                // fontFamily: "PulpDisplay",
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Appcolors().loginhintcolor),
          ),
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }

  Widget daydivider() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Appcolors().loginhintcolor,
              // alignment: Alignment.centerLeft,
              width: 32.w,
              height: 0.1.h,
            ),
            Text(
              "Mon 8 Mar 2023",
              style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: "PulpDisplay",
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: Appcolors().loginhintcolor),
              textAlign: TextAlign.center,
            ),
            Container(
              color: Appcolors().loginhintcolor,
              // alignment: Alignment.centerLeft,
              width: 32.w,
              height: 0.1.h,
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print("Image path:-${pickedFile.path}");
      });
    }
  }
  clickphotofromcamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print("Image path:-${pickedFile.path}");

      });
    }
  }
  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print("Video path:-${pickedFile?.path}");

      // print("Video path:-${pickedFile.path}");
    }

    return null;
  }

  @override
  void dispose() {
    messagecontroller.dispose();
    super.dispose();
  }

}
