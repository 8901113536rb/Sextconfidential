import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sextconfidential/Bottomnavigation.dart';
import 'package:sextconfidential/main.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
import 'package:sextconfidential/utils/Helpingwidgets.dart';
import 'package:sextconfidential/utils/Sidedrawer.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class MassmessageScreen extends StatefulWidget{
  @override
  MassmessageScreenState createState() => MassmessageScreenState();

}

class MassmessageScreenState extends State<MassmessageScreen>{
  List<String>massmessagetype=["All Available","Favourites","Create New group"];
  String dropdownvalue="All Available";
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  List<String>messagehistorytype=[StringConstants.mostrecent,StringConstants.mostsends,StringConstants.mostread,StringConstants.readrate,StringConstants.mostunlocks,StringConstants.mostearnings,];
  String messagehistoryvalue="Most Recent";
  TextEditingController messagecontroller=TextEditingController();
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;
  late final VideoPlayerController videoPlayerController;
  int imagecredit=1;
  File? imageFile;
  bool videostatus=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   startvideo();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
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
        padding: EdgeInsets.only(left: 3.w,right: 3.w),
        color: Appcolors().backgroundcolor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                        style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
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
                            fillColor: Appcolors().messageboxbgcolor,
                            hintText:
                            StringConstants.whatareyouupto,
                            hintStyle: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              // fontFamily: 'PulpDisplay',
                              color: Appcolors().loginhintcolor,
                            ),),
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
                      onTap: (){
                        
                      },
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
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child:
                            imageFile==null?
                            GestureDetector(
                              onTap: (){
                                addmediadialog(context);
                              },
                              child: Container(
                                height: 5.h,
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: SvgPicture.asset("assets/images/uploadimageicon.svg",height: 3.h,width: 3.w,)),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      StringConstants.addphotosorvideo,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          // fontFamily: "PulpDisplay",
                                          fontWeight: FontWeight.w500,
                                          color: Appcolors().loginhintcolor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                                // color: Colors.amber,
                              ),
                            )
                            :
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                          padding:EdgeInsets.all(10),
                                          child: Image.file(imageFile!,height:15.h,width:25.w,fit: BoxFit.fill,)),
                                      GestureDetector(
                                        onTap: (){
                                          setState((){
                                            imageFile=null;

                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 1.h,
                                          backgroundColor: Colors.white,
                                          child: Image.asset("assets/images/crossicon.png",height: 1.h,),
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
                                      width:20.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Appcolors().loginhintcolor),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Text(
                                        imagecredit.toString(),
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            fontFamily: "PulpDisplay",
                                            fontWeight: FontWeight.w400,
                                            color: Appcolors().whitecolor),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if(imagecredit>1){
                                            imagecredit=imagecredit-1;
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.w),
                                        alignment: Alignment.center,
                                        width: 4.w,
                                        height: 2.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              fontFamily: "PulpDisplay",
                                              fontWeight: FontWeight.w400,
                                              color: Appcolors().blackcolor),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                            imagecredit=imagecredit+1;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20.w),
                                        alignment: Alignment.center,
                                        width: 4.w,
                                        height: 2.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/btnbackgroundgradient.png"),fit: BoxFit.fill
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              fontFamily: "PulpDisplay",
                                              fontWeight: FontWeight.w400,
                                              color: Appcolors().blackcolor),
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
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/btnbackgroundgradient.png"),fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
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
                    AnimationLimiter(
                      child: ListView.builder(
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
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(2.h),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Appcolors().chatuserborder),
                                          borderRadius: BorderRadius.circular(2.h)
                                      ),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          index%2==0?
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  // Future.delayed(Duration(seconds: 1), () {
                                                    videoplayer(context);
                                                  // });
                                                },
                                                child: Container(
                                                  width:35.w,
                                                  height: 16.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                        image: AssetImage("assets/images/modelimage.png",),fit: BoxFit.fill
                                                    ),
                                                  ),
                                                  child: Icon(Icons.play_circle_outline_rounded,color: Colors.white,),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          ):
                                          const SizedBox(),
                                          Container(
                                            decoration: BoxDecoration(
                                                color:Appcolors().loginhintcolor,
                                                borderRadius: BorderRadius.circular(1.5.h)
                                            ),
                                            padding:EdgeInsets.only(left: 3.w,right: 3.w,top: 1.5.h,bottom: 1.5.h),
                                            child: Text("Babe wanna video call?",style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: "PulpDisplay",
                                                fontWeight: FontWeight.w400,
                                                color: Appcolors().backgroundcolor),),
                                          ),
                                          SizedBox(
                                            height: 1.h ,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Text("Sent 23/04/2023 01:30 am",style: TextStyle(
                                                fontSize: 10.sp,
                                                // fontFamily: "PulpDisplay",
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: Appcolors().loginhintcolor,),textAlign: TextAlign.end,),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Divider(
                                            thickness: 1.2,
                                            height: 1.h,
                                            color: Appcolors().dividercolor
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Container(
                                                    child:  GradientText(
                                                      "1343",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontFamily: "PulpDisplay",
                                                          fontWeight: FontWeight.w500),
                                                      gradientType: GradientType.linear,
                                                      gradientDirection: GradientDirection.ttb,
                                                      radius: 8,
                                                      colors: [
                                                        Appcolors().gradientcolorfirst,
                                                        Appcolors().gradientcolorsecond,
                                                      ],
                                                    ),
                                                  ),SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Container(
                                                    child: Text(StringConstants.sent,style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontFamily: "PulpDisplay",
                                                      fontWeight: FontWeight.w400,
                                                      color: Appcolors().loginhintcolor,),textAlign: TextAlign.end,),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 6.h,
                                                  width: 1.5,
                                                color: Appcolors().dividercolor
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Container(
                                                    child:  GradientText(
                                                      "245",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontFamily: "PulpDisplay",
                                                          fontWeight: FontWeight.w500),
                                                      gradientType: GradientType.linear,
                                                      gradientDirection: GradientDirection.ttb,
                                                      radius: 6,
                                                      colors: [
                                                        Appcolors().gradientcolorfirst,
                                                        Appcolors().gradientcolorsecond,
                                                      ],
                                                    ),
                                                  ),SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Container(
                                                    child: Text(StringConstants.reads,style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontFamily: "PulpDisplay",
                                                      fontWeight: FontWeight.w400,
                                                      color: Appcolors().loginhintcolor,),textAlign: TextAlign.end,),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 6.h,
                                                width: 1.5,
                                                color: Appcolors().dividercolor
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Container(
                                                    child:  GradientText(
                                                      "17.2%",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontFamily: "PulpDisplay",
                                                          fontWeight: FontWeight.w500),
                                                      gradientType: GradientType.linear,
                                                      gradientDirection: GradientDirection.ttb,
                                                      radius: 6,
                                                      colors: [
                                                        Appcolors().gradientcolorfirst,
                                                        Appcolors().gradientcolorsecond,
                                                      ],
                                                    ),
                                                  ),SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Container(
                                                    child: Text(StringConstants.readrate,style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontFamily: "PulpDisplay",
                                                      fontWeight: FontWeight.w400,
                                                      color: Appcolors().loginhintcolor,),textAlign: TextAlign.end,),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ),
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

                  ],
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

              content: StatefulBuilder(  // You need this, notice the parameters below:
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
                              (MediaQuery.of(context)
                                  .size
                                  .height /
                                  100) *
                                  50,
                              child: AspectRatio(
                                aspectRatio: _controller
                                    .value.aspectRatio,
                                child:
                                CustomVideoPlayer(
                                  customVideoPlayerController: _customVideoPlayerController,

                                ),
                                // VideoPlayer(
                                //     _controller),
                              )),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child:
                            Container(
                              margin: EdgeInsets.only(right: 5.w,top: 1.h),
                              height: 4.h,
                              width: 4.w,
                              alignment: Alignment.topRight,
                              child: Image.asset("assets/images/crossicon.png",color: Colors.white,height: 4.h,
                                width: 4.w,),
                            ),
                          ),
                        ],
                      )
                  );
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
              content: StatefulBuilder(  // You need this, notice the parameters below:
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
                                  capturevideo();
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
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: 1.5.h,
                          backgroundColor: Colors.white,
                          child: Image.asset("assets/images/crossicon.png",height: 1.5.h,),
                        ),
                      ),

                    ],
                  );
                },
              ),
          );
        });
  }
  void startvideo(){

    setState(() {
      videoPlayerController = VideoPlayerController.network("https://coderzbar.info/dev/worldofquotes_dev/storage/app/public/author/498330079authorimage.mp4")
        ..initialize().then((value) => setState(() {
          print("Video working");
          var durationOfVideo = videoPlayerController.value.position.inSeconds.round();
          print("Duration of video:-"+durationOfVideo.toString());
          debugPrint("========"+_controller.value.duration.toString());

        }));
      _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
      );
      _controller = VideoPlayerController.network(
          "https://coderzbar.info/dev/worldofquotes_dev/storage/app/public/author/498330079authorimage.mp4")
        ..initialize().then((_) {
          setState(() {
            debugPrint("========"+_controller.value.duration.toString());
            print("Video Started");
            var durationOfVideo = videoPlayerController.value.position.inSeconds.round();
            print("Duration of videos:-"+durationOfVideo.toString());
          });
        },
        );


    });
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
      });
    }
  }
  capturevideo() async {
    PickedFile? pickedFile = await ImagePicker().getVideo(
      preferredCameraDevice: CameraDevice.rear,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

}