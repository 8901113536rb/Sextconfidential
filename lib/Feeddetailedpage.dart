import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomMenu.dart';
import 'package:sextconfidential/utils/Helpingwidgets.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Feeddetailedpage extends StatefulWidget{
  String? type,url,ago,text,views,likes,unlocks;
  int? posttype;
  Feeddetailedpage({super.key,this.type,this.url,this.ago,this.text,this.views,this.likes,this.unlocks,this.posttype});

  @override
  FeeddetailedpageState createState() => FeeddetailedpageState();

}

class FeeddetailedpageState extends State<Feeddetailedpage>{
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;
  late final VideoPlayerController videoPlayerController;
  int? editedpostid;
  bool videostatus=false;
  bool editpost=false;
  TextEditingController postcontentcontoller = TextEditingController(text: "What are you up to tonight?");
  String? token,userprofilepic,username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsharedpreference();
    if(widget.type=="mp4"){
      startvideo();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors().backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolors().bottomnavbgcolor,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
            print("Click back");
          },
          child: Container(
            // color: Colors.white,
              margin: EdgeInsets.only(left: 2.w),
              child: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        title: Text(StringConstants.feed,style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "PulpDisplay",
            fontWeight: FontWeight.w500,
            color: Appcolors().whitecolor),),
      ),
      body: Container(
        padding: EdgeInsets.all(1.5.h),
        decoration: BoxDecoration(
            border: Border.all(color: Appcolors().chatuserborder),
            borderRadius: BorderRadius.circular(2.h)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child:
                      userprofilepic==null||userprofilepic==""?
                      Image.asset("assets/images/userprofile.png",height: 4.5.h,width: 15.w,):
                      CachedNetworkImage(
                        imageUrl:userprofilepic.toString(),
                        imageBuilder: (context,
                            imageProvider) =>
                            Container(
                              width: 15.w,
                              alignment: Alignment
                                  .centerLeft,
                              height: 4.5.h,
                              decoration:
                              BoxDecoration(
                                shape: BoxShape.circle,
                                image:
                                DecorationImage(
                                  image:
                                  imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder:
                            (context, url) =>
                            Container(
                              child: Center(
                                child:
                                CircularProgressIndicator(strokeWidth: 2,color: Appcolors().backgroundcolor,),
                              ),
                            ),
                        // errorWidget: (context, url, error) => errorWidget,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username.toString(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w400,
                              color: Appcolors().whitecolor),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.ago.toString(),
                          style: TextStyle(
                              fontSize: 10.sp,
                              // fontFamily: "PulpDisplay",
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: Appcolors().loginhintcolor),
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  ],
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: Image.asset("assets/images/menubtn.png",height: 4.h,fit: BoxFit.fill,),
                    items: [
                      ...MenuItems.firstItems.map(
                            (item) => DropdownMenuItem<CustomMenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
                      ...MenuItems.secondItems.map(
                            (item) => DropdownMenuItem<CustomMenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      MenuItems.onChanged(context, value as CustomMenuItem);
                      print("Value:-"+value.text);
                      if(value.text==StringConstants.editpost){
                        setState((){
                         editpost=true;
                        });
                      }else if(value.text==StringConstants.deletepost){
                        showdeletealert(context);
                      }
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: 160,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Appcolors().bottomnavbgcolor,
                      ),
                      elevation: 8,
                      offset: const Offset(0, 8),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled(MenuItems.firstItems.length, 35),
                        8,
                        ...List<double>.filled(MenuItems.secondItems.length, 48),
                      ],
                      padding: const EdgeInsets.only(left: 16, right: 16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            widget.type=="mp4"?
            !videostatus?
            Container(
              alignment: Alignment.center,
              height: 50.h,
              child: Helpingwidgets().customloader(),
            ):
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20)
              ),
                width: 80.h,
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
                )):
            Container(
              width:double.infinity,
              height: 50.h,
              child: CachedNetworkImage(
                imageUrl:widget.url.toString(),
                imageBuilder: (context,
                    imageProvider) =>
                    Container(
                      width: 15.w,
                      alignment: Alignment
                          .centerLeft,
                      height: 4.5.h,
                      decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        image:
                        DecorationImage(
                          image:
                          imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                placeholder:
                    (context, url) =>
                    Container(
                      child: Center(
                        child:
                        CircularProgressIndicator(strokeWidth: 2,color: Appcolors().backgroundcolor,),
                      ),
                    ),
                // errorWidget: (context, url, error) => errorWidget,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Offstage(
              offstage: widget.text==null,
              child:  Column(
                children: [
                  editpost!=true?
                  Text(
                    widget.text.toString(),
                    style: TextStyle(
                        fontSize: 12.sp,
                        // fontFamily: "PulpDisplay",
                        fontWeight: FontWeight.w500,
                        color: Appcolors().whitecolor),
                    textAlign: TextAlign.start,
                  ):
                  Container(
                      child: Column(
                        children: [
                          TextFormField(
                            minLines: 3,
                            maxLines: 3,
                            cursorColor: Appcolors().loginhintcolor,
                            style: TextStyle(
                              color: Appcolors().whitecolor,
                              fontSize: 12.sp,
                            ),
                            controller: postcontentcontoller,
                            decoration: InputDecoration(
                              // prefix: Container(
                              //   child: SvgPicture.asset("assets/images/astrickicon.svg",width: 5.w,),
                              // ),
                              border: InputBorder.none,
                              // focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                BorderSide(color: Appcolors().logintextformborder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                BorderSide(color: Appcolors().logintextformborder),
                              ),
                              filled: true,
                              fillColor: Appcolors().messageboxbgcolor,
                              hintText: StringConstants.writesomething,
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
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/btnbackgroundgradient.png"),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 5.h,
                                child: Text(
                                  StringConstants.update,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "PulpDisplay",
                                      fontWeight: FontWeight.w400,
                                      color: Appcolors().backgroundcolor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState((){
                                    editpost=false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 40.w,
                                  height: 5.h,
                                  child: Text(
                                    StringConstants.cancel,
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
                          )
                        ],
                      )
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              )
            ),
            widget.posttype==0?
            Container(
              width: 75.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/images/likeicon.svg"),
                        Text(
                          widget.likes.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              // fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w600,
                              color: Appcolors().loginhintcolor),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/images/viewsicon.svg"),
                        Text(
                          widget.views.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              // fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w600,
                              color: Appcolors().loginhintcolor),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/images/unlockicon.svg"),
                        Text(
                          widget.unlocks.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              // fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w600,
                              color: Appcolors().loginhintcolor),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            :SizedBox(),
            SizedBox(
              height: 1.h,
            ),

          ],
        ),
      ),
    );
  }
  void startvideo(){
      videoPlayerController = VideoPlayerController.network(widget.url.toString())
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
      _controller = VideoPlayerController.network(widget.url.toString())
        ..initialize().then((_) {
          setState(() {
            debugPrint("========"+_controller.value.duration.toString());
            print("Video Started");
            videostatus=true;
            var durationOfVideo = videoPlayerController.value.position.inSeconds.round();
            print("Duration of videos:-"+durationOfVideo.toString());
          });
        },
        );
  }
  Future<void> showdeletealert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              backgroundColor: Appcolors().dialogbgcolor,
              //title: Text("Image Picker"),
              content: Container(
                alignment: Alignment.center,
                height: 25.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringConstants.deletediologmessage,style: TextStyle(
                        fontSize: 14.sp,
                        height: 0.2.h,
                        // fontFamily: "PulpDisplay",
                        fontWeight: FontWeight.w500,
                        color: Appcolors().loginhintcolor),textAlign: TextAlign.center,),
                    SizedBox(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Appcolors().deactivatecolor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: 40.w,
                          height: 5.h,
                          child:  Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/deleteicon.svg",height: 3.h,),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(StringConstants.deletepost,style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "PulpDisplay",
                                  fontWeight: FontWeight.w500,
                                  color: Appcolors().whitecolor),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(StringConstants.cancel,style: TextStyle(
                          fontSize: 14.sp,
                          height: 0.2.h,
                          // fontFamily: "PulpDisplay",
                          fontWeight: FontWeight.w500,
                          color: Appcolors().whitecolor),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              )
          );
        });
  }
  Future<void> getsharedpreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("token");
      userprofilepic=sharedPreferences.getString("profilepic");
      username=sharedPreferences.getString("stagename");
    });
    print("Token value:-" + token.toString());
    print("Userprofile value:-" + userprofilepic.toString());

  }
}