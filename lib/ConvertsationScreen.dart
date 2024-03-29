import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/tau.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
// import 'package:record_mp3/record_mp3.dart';
import 'package:sextconfidential/UserprofileScreen.dart';
import 'package:sextconfidential/Videoscreen.dart';
import 'package:sextconfidential/pojo/Chatmessagespojo.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/Helpingwidgets.dart';
import 'package:sextconfidential/utils/Networks.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:voice_message_package/voice_message_package.dart';
// import 'package:voice_message_package/voice_message_package.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class ConvertsationScreen extends StatefulWidget {
  String userid, userimage, username;
  ConvertsationScreen(
      {super.key,
      required this.userid,
      required this.userimage,
      required this.username});

  @override
  ConvertsationScreenState createState() => ConvertsationScreenState();
}

class ConvertsationScreenState extends State<ConvertsationScreen> {
  TextEditingController messagecontroller = TextEditingController();
  bool showuploaddialog = false;
  bool emojiShowing = false;
  File? imageFile,recordingaudio;
  FocusNode messsagefocus = FocusNode();
  bool micstatus = false;
  String statusText = "";
  bool isComplete = false;
  String recordingTime = '0:0'; // to store value
  bool isRecording = false;
  String? token, userprofilepic, username;
  bool responsestatus = false;
  Chatmessagespojo? chatmessagespojonew;
  Chatmessagespojo? chatmessagespojo2;
  Chatmessagespojo? chatmessagespojo;
  GlobalKey<State> key = GlobalKey();
  Timer? _timer;
  bool condition = false;
  ScrollController _controller = ScrollController();
  String? chatcurrentdate;
  int messageslength=0;
  FlutterSound flutterSound=FlutterSound();
  final recorder = FlutterSoundRecorder();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRecorder();
    checkPermission();
    getsharedpreference();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _timer!.cancel();
        if (emojiShowing == true) {
          setState(() {
            emojiShowing = false;
            showuploaddialog = false;
            micstatus = false;
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
              _timer!.cancel();
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
              print("Scroll down");
              // _scrollDown();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserprofileScreen(
                            username: widget.username.toString(),
                            userimage: widget.userimage.toString(),
                            userid: widget.userid.toString(),
                          )));
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
                          imageUrl: widget.userimage.toString(),
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
                                color: Appcolors().gradientcolorfirst,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 16.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/userprofile.png"))),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.username.toString(),
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
            alignment: Alignment.center,
            // padding: EdgeInsets.only(left: 2.w, right: 2.w),
            color: Appcolors().backgroundcolor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    responsestatus
                        ? chatmessagespojo!.data!.isNotEmpty||chatmessagespojo!.data==null
                            ? Expanded(
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    // reverse: true,
                                    controller: _controller,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: chatmessagespojo!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showuploaddialog = false;
                                                  emojiShowing = false;
                                                  // micstatus = false;
                                                  FocusManager
                                                      .instance.primaryFocus
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        chatcurrentdate !=
                                                                chatmessagespojo!
                                                                    .data!
                                                                    .elementAt(
                                                                        index)!
                                                                    .createdAt
                                                                    .toString()
                                                                    .substring(
                                                                        0, 13)
                                                            ? daydivider(
                                                                chatmessagespojo!
                                                                    .data!
                                                                    .elementAt(
                                                                        index)!
                                                                    .createdAt
                                                                    .toString()
                                                                    .substring(
                                                                        0, 13))
                                                            : SizedBox(),
                                                        chatmessagespojo!.data!
                                                                    .elementAt(
                                                                        index)!
                                                                    .fromId
                                                                    .toString() !=
                                                                token
                                                            ? sendermessage(
                                                                index)
                                                            : receivermessage(
                                                                index),
                                                        // voicemessage()
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
                              )
                            : Center(
                                child: Helpingwidgets.emptydatawithoutdivider(
                                    "No Message!"))
                        : SizedBox(),
                    SizedBox(
                      height: 7.h,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Offstage(
                      offstage: !micstatus,
                      child: miccontainer(),
                    ),
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
                              // !micstatus?
                              Container(
                                height: 5.h,
                                width: 80.w,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
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
                                        focusNode: messsagefocus,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          // focusedBorder: InputBorder.none,
                                          filled: true,
                                          fillColor:
                                              Appcolors().bottomnavbgcolor,
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
                                          color: showuploaddialog
                                              ? Appcolors().gradientcolorsecond
                                              : Appcolors().whitecolor,
                                        )),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                  ],
                                ),
                              ),
                              !micstatus && messagecontroller.text.isEmpty
                                  ? GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          showuploaddialog = false;
                                          micstatus = true;
                                          startRecord();
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/micicon.svg",
                                        height: 2.5.h,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            if (_controller.hasClients) {
                                              _controller.jumpTo(_controller
                                                  .position.maxScrollExtent);
                                            }
                                          });
                                          if (messagecontroller.text
                                              .toString()
                                              .trim()
                                              .isNotEmpty) {
                                            sendmessage();
                                          }
                                          recordingTime = "0:0";
                                          micstatus = false;
                                          // stopRecord();
                                          messagecontroller.text = "";
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/sendicon.svg",
                                        height: 2.5.h,
                                      ),
                                    ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                        )),
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
                              bgColor: Appcolors().backgroundcolor,
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor:
                                  Appcolors().backgroundcolor,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              // showRecentsTab: true,
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
      margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
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
              setState((){
              showuploaddialog=false;
              });
              // Navigator.pop(context);
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
              setState((){
                showuploaddialog=false;
              });
              // Navigator.pop(context);
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
              setState((){
                showuploaddialog=false;
              });
              // Navigator.pop(context);
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

  Widget miccontainer() {
    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.h),
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
              stopRecorder();
              setState((){
                micstatus=false;
              });
            },
            child: SvgPicture.asset(
              "assets/images/deleteicon.svg",
              height: 3.h,
              width: 3.w,
              color: Appcolors().bottomnavbgcolor,
            ),
          ),
          GestureDetector(
              onTap: () {
                // Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 4.5.h,
                backgroundColor: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/micicon.svg",
                      height: 2.5.h,
                      color: Appcolors().gradientcolorfirst,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    StreamBuilder<RecordingDisposition>(
                      builder: (context, snapshot) {
                        final duration = snapshot.hasData
                            ? snapshot.data!.duration
                            : Duration.zero;

                        String twoDigits(int n) => n.toString().padLeft(2, '0');

                        final twoDigitMinutes =
                        twoDigits(duration.inMinutes.remainder(60));
                        final twoDigitSeconds =
                        twoDigits(duration.inSeconds.remainder(60));
                        return Text(
                          '$twoDigitMinutes:$twoDigitSeconds',
                          style: TextStyle(
                              fontSize: 12.sp,
                              // fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w400,
                              color: Appcolors().gradientcolorfirst),
                        );
                      },
                      stream: recorder.onProgress,
                    ),

                  ],
                ),
              )),
          GestureDetector(
            onTap: () {
              stopandsendRecorder();
              setState((){
                micstatus=false;
              });
            },
            child: SvgPicture.asset(
              "assets/images/sendicon.svg",
              height: 3.h,
              width: 3.w,
              color: Appcolors().bottomnavbgcolor,
            ),
          ),
        ],
      ),
    );
  }

  Widget receivermessage(int index) {
    // setState((){
    chatcurrentdate = chatmessagespojo!.data!
        .elementAt(index)!
        .createdAt
        .toString()
        .substring(0, 13);
    // });
    return Column(
      children: [
        chatmessagespojo!.data!.elementAt(index).messageType.toString() ==
                "text"
            ? Container(
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
                        chatmessagespojo!.data!
                            .elementAt(index)
                            .message
                            .toString(),
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
                    messagetime(index),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              )
            : chatmessagespojo!.data!.elementAt(index).messageType == "mp4"
                ? Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w),
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Videoscreen(
                                        videopath: chatmessagespojo!.data!
                                            .elementAt(index)
                                            .message
                                            .toString())));
                          },
                          child: Container(
                            height: 15.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/videodefaultimg.png",
                                    ),
                                    fit: BoxFit.fill)),
                            child: Icon(
                              Icons.play_circle_outline_rounded,
                              color: Colors.white,
                              size: 6.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        messagetime(index),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ):
        chatmessagespojo!.data!.elementAt(index)!.messageType.toString()=="mp3"?
        voicemessage(chatmessagespojo!.data!.elementAt(index)!.message.toString(),index)
                : Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w),
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Helpingwidgets().mediaimagedialog(
                                context,
                                chatmessagespojo!.data!
                                    .elementAt(index)
                                    .message
                                    .toString());
                          },
                          child: Container(
                            height: 15.h,
                            width: 40.w,
                            child: CachedNetworkImage(
                              imageUrl: chatmessagespojo!.data!
                                  .elementAt(index)
                                  .message
                                  .toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                                    color: Appcolors().gradientcolorfirst,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 15.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imageplaceholder.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        messagetime(index),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
      ],
    );
  }

  Widget sendermessage(int index) {
    // setState((){
    chatcurrentdate = chatmessagespojo!.data!
        .elementAt(index)!
        .createdAt
        .toString()
        .substring(0, 13);
    // });
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              chatmessagespojo!.data!.elementAt(index).messageType.toString() ==
                      "text"
                  ? Container(
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
                        chatmessagespojo!.data!
                            .elementAt(index)
                            .message
                            .toString(),
                        style: TextStyle(
                            fontSize: 11.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w500,
                            // fontStyle: FontStyle.italic,
                            color: Appcolors().whitecolor),
                      ),
                    )
                  : chatmessagespojo!.data!
                              .elementAt(index)
                              .messageType
                              .toString() ==
                          "mp4"
                      ? Container(
                          margin: EdgeInsets.only(left: 6.w),
                          padding: EdgeInsets.only(
                              right: 4.w, left: 8.w, top: 2.h, bottom: 2.h),
                          decoration: BoxDecoration(
                            color: Appcolors().profileboxcolor,
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle,
                          ),
                          height: 15.h,
                          width: 40.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Videoscreen(
                                              videopath: chatmessagespojo!.data!
                                                  .elementAt(index)
                                                  .message
                                                  .toString())));
                                },
                                child: Container(
                                  height: 10.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                            "assets/images/videodefaultimg.png",
                                          ),
                                          fit: BoxFit.cover)),
                                  child: Icon(
                                    Icons.play_circle_outline_rounded,
                                    color: Colors.white,
                                    size: 3.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):
                  chatmessagespojo!.data!.elementAt(index)!.messageType.toString()=="mp3"?
                  voicemessage(chatmessagespojo!.data!.elementAt(index)!.message.toString(),index)
                      : Container(
                          margin: EdgeInsets.only(left: 6.w),
                          padding: EdgeInsets.only(
                              right: 4.w, left: 8.w, top: 2.h, bottom: 2.h),
                          decoration: BoxDecoration(
                            color: Appcolors().profileboxcolor,
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle,
                          ),
                          height: 15.h,
                          width: 40.w,
                          child: InkWell(
                            onTap: () {
                              Helpingwidgets().mediaimagedialog(
                                  context,
                                  chatmessagespojo!.data!
                                      .elementAt(index)
                                      .message
                                      .toString());
                            },
                            child: CachedNetworkImage(
                              imageUrl: chatmessagespojo!.data!
                                  .elementAt(index)
                                  .message
                                  .toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                                    color: Appcolors().gradientcolorfirst,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 15.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imageplaceholder.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
              Container(
                height: 6.h,
                width: 11.w,
                padding: EdgeInsets.all(0.6.h),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Appcolors().backgroundcolor),
                child: CachedNetworkImage(
                  imageUrl: widget.userimage.toString(),
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
                        color: Appcolors().gradientcolorfirst,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 15.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/userprofile.png"))),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, top: 0.5.h),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: messagetime(index),
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }

  Widget daydivider(String datedata) {
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
              datedata.toString(),
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
        sendmessage();
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
        sendmessage();
      });
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print("Video path:-${pickedFile?.path}");
      sendmessage();
      // print("Video path:-${pickedFile.path}");
    }
    return null;
  }

  Widget voicemessage(String audiosrc,int index) {
    return Container(
      alignment: Alignment.centerRight,
      // width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          VoiceMessage(
            mePlayIconColor: Appcolors().profileboxcolor,
            // meFgColor: Appcolors().bottomnavbgcolor,
            meBgColor: Appcolors().profileboxcolor,
            contactFgColor: Appcolors().profileboxcolor,
            audioSrc:audiosrc,
            // audioSrc: "https://samplelib.com/lib/preview/mp3/sample-9s.mp3",
            played: true, // To show played badge or not.
            me: true, // Set message side.
            onPlay: () {}, // Do something when voice played.
          ),
          messagetime(index)

        ],
      ),
    );
  }

  @override
  void dispose() {
    messagecontroller.dispose();
    messsagefocus.dispose();
    _timer!.cancel();
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    await Permission.microphone.request();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: "audio");
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    setState((){
      imageFile = File(filePath!);
    });
  }
  Future stopandsendRecorder() async {
    final filePath = await recorder.stopRecorder();
    setState((){
      imageFile = File(filePath!);
    });
    sendmessage();
    print("Recorded file path:"+ recordingaudio!.path.toString());
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  // Future<String> getFilePath() async {
  //   Directory storageDirectory = await getApplicationDocumentsDirectory();
  //   String sdPath = storageDirectory.path + "/record";
  //   var d = Directory(sdPath);
  //   if (!d.existsSync()) {
  //     d.createSync(recursive: true);
  //   }
  //   return sdPath + "/test_${i++}.mp3";
  // }

  Future<void> getsharedpreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("token")!;
      userprofilepic = sharedPreferences.getString("profilepic");
      username = sharedPreferences.getString("stagename");
    });
    print("Token value:-" + token.toString());
    chatconversationlisting();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print(DateTime.now());
      setState(() {
        chatconversationlisting();
        print("Chat conversin api call");
      });
    });
  }

  Future<void> chatconversationlisting() async {
    // Helpingwidgets.showLoadingDialog(context, key);
    Map data = {
      "token": token,
      "toid": widget.userid.toString(),
    };
    print("Data:-" + data.toString());
    var jsonResponse = null;
    var response = await http
        .post(Uri.parse(Networks.baseurl + Networks.chatmessage), body: data);
    jsonResponse = json.decode(response.body);
    print("jsonResponse:-" + jsonResponse.toString());
    if (response.statusCode == 200) {
      if (jsonResponse["status"] == false) {
        setState(() {
          responsestatus = true;
        });
        // Navigator.pop(context);
        Helpingwidgets.failedsnackbar(
            jsonResponse["message"].toString(), context);
        Navigator.pop(context);
      } else {
        setState(() {
          responsestatus = true;
          print("Message:-" + jsonResponse["message"].toString());

          chatmessagespojo = Chatmessagespojo.fromJson(jsonResponse);
          // chatmessagespojo2=chatmessagespojonew;
          //   if(chatmessagespojo!=chatmessagespojo2){
          //     chatmessagespojo=chatmessagespojo2;
          //   }else {
          //     chatmessagespojo ??= chatmessagespojo2;
          //   }
          if(messageslength<chatmessagespojo!.data!.length && messageslength!=0){
            _controller.jumpTo(_controller.position.maxScrollExtent);
            _controller!.animateTo(_controller.position.maxScrollExtent,
                duration: Duration(milliseconds: 1), curve: Curves.easeOut);
            print("New message received!");
          }
          messageslength=chatmessagespojo!.data!.length;
        });
          if (_controller.position.pixels ==
              _controller.position.minScrollExtent ||
              _controller.position.pixels ==
                  _controller.position.maxScrollExtent) {
            _controller.jumpTo(_controller.position.maxScrollExtent);
            _controller!.animateTo(_controller.position.maxScrollExtent,
                duration: Duration(milliseconds: 1), curve: Curves.easeOut);
          }
      }
    } else {
      // Navigator.pop(context);
      setState(() {
        responsestatus = true;
      });
      Helpingwidgets.failedsnackbar(
          jsonResponse["message"].toString(), context);
    }
  }
  Future<void> sendmessage() async {
    // Helpingwidgets.showLoadingDialog(context, key);
    var request = http.MultipartRequest(
      'post',
      Uri.parse(Networks.baseurl + Networks.chatmessagesend),
    );
    var jsonData = null;
    request.headers["Content-Type"] = "multipart/form-data";
    request.fields["toid"] = widget.userid.toString();
    request.fields["token"] = token!;
    print("token:-" + token!.toString());
    print("Message:-" + messagecontroller.text.trim());
    if (imageFile != null) {
      print("Image message send");
      print("File path on api call:-"+imageFile!.path.toString());
      request.files.add(
        await http.MultipartFile.fromPath("file", imageFile!.path,
            filename: imageFile!.path),
      );
    } else {
      print("Simple message send");
      request.fields["file"] = messagecontroller.text!;
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
          setState(() {
            imageFile = null;
          });
          messagecontroller.clear();
          // Helpingwidgets.successsnackbar(
          //     jsonData["message"].toString(), context);
          print("Response:${jsonData["message"]}");
          // Navigator.pop(context);
        }
      } else {
        Helpingwidgets.failedsnackbar(jsonData["message"].toString(), context);
        print("Response:${jsonData["message"]}");
        // Navigator.pop(context);
      }
    });
  }

  Future scrollToBottom(ScrollController scrollController) async {
    while (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      await SchedulerBinding.instance!.endOfFrame;
    }
  }

  Widget messagetime(int index){
    return  Text(
      "Sent  "+chatmessagespojo!.data!
          .elementAt(index)
          .createdAt
          .toString()
          .substring(14, 22),
      // "Send for ${chatmessagespojo!.data!.elementAt(index).type}"=="free"?+chatmessagespojo!.data!.elementAt(index).createdAt.toString().substring(0,10),
      style: TextStyle(
          fontSize: 10.sp,
          // fontFamily: "PulpDisplay",
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: Appcolors().loginhintcolor),
      textAlign: TextAlign.center,
    );
  }

}
