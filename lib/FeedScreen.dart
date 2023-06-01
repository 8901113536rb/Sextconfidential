import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sextconfidential/Feeddetailedpage.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
import 'package:sextconfidential/utils/CustomMenu.dart';
import 'package:sextconfidential/utils/Sidedrawer.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FeedScreen extends StatefulWidget {
  @override
  FeedScreenState createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  TextEditingController messagecontroller = TextEditingController();
  TextEditingController postcontentcontoller =
      TextEditingController(text: "What are you up to tonight?");
  List<String> posttypes = ["Scheduled Post", "Save as Draft"];
  List<String> postfilters = [
    StringConstants.mostrecent,
    StringConstants.mostsends,
    StringConstants.mostread,
    StringConstants.readrate,
    StringConstants.mostunlocks,
    StringConstants.mostearnings,
  ];
  List<String> menuoptions = [
    StringConstants.editpost,
    StringConstants.copylink,
    StringConstants.pinpost,
    StringConstants.deletepost,
  ];
  String postselectedvalue = "Scheduled Post";
  String selectedmenu = StringConstants.editpost;
  String postfiltervalue = StringConstants.mostrecent;
  bool posttoexplore = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int? editedpostid;
  File? imageFile;
  int imagecredit = 1;
  Uint8List? thumbnail;
  int selectedposttype = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      //   title: Text(StringConstants.feed,style: TextStyle(
      //       fontSize: 14.sp,
      //       fontFamily: "PulpDisplay",
      //       fontWeight: FontWeight.w500,
      //       color: Appcolors().whitecolor),),
      // ),
      body: Container(
        padding: EdgeInsets.only(left: 3.w, right: 3.w),
        color: Appcolors().backgroundcolor,
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
                    StringConstants.posttoprofile,
                    style: TextStyle(
                        fontSize: 11.sp,
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
                      dropdownItems: posttypes,
                      value: postselectedvalue,
                      dropdownWidth: 45.w,
                      dropdownHeight: 60.h,
                      buttonWidth: 27.w,
                      onChanged: (value) {
                        setState(() {
                          postselectedvalue = value!;
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
                      borderSide:
                          BorderSide(color: Appcolors().logintextformborder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Appcolors().logintextformborder),
                    ),
                    filled: true,
                    isDense: true,
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
                      borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                    imageFile!.path.length - 3,
                                                    imageFile!.path.length) ==
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
                                              color:
                                                  Appcolors().loginhintcolor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                      onTap: () {
                                        setState(() {
                                          if (imagecredit > 1) {
                                            imagecredit = imagecredit - 1;
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20.w),
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
                                              fontWeight: FontWeight.w400,
                                              color: Appcolors().blackcolor),
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
                                        margin: EdgeInsets.only(left: 20.w),
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
                                                BorderRadius.circular(5)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Appcolors().checkboxcolor,
                        ),
                        height: 2.5.h,
                        width: 2.5.h,
                        child: Checkbox(
                          fillColor:
                              MaterialStateProperty.all(Colors.transparent),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          checkColor: Appcolors().backgroundcolor,
                          activeColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          value: posttoexplore,
                          onChanged: (value) {
                            setState(() {
                              posttoexplore = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        child: Text(
                          StringConstants.posttoexplore,
                          style: TextStyle(
                              fontSize: 10.sp,
                              // fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w400,
                              color: Appcolors().loginhintcolor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 40.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/btnbackgroundgradient.png"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(10)),
                    height: 5.h,
                    child: Text(
                      StringConstants.postnow,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "PulpDisplay",
                          fontWeight: FontWeight.w400,
                          color: Appcolors().backgroundcolor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Appcolors().bottomnavbgcolor,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(6),
                alignment: Alignment.center,
                height: 5.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedposttype = 0;
                        });
                      },
                      child: GradientText(
                        "${StringConstants.posted}(199)",
                        style: TextStyle(
                            fontSize: 9.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w400),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ttb,
                        radius: 6,
                        colors: [
                          selectedposttype==0?Appcolors().gradientcolorfirst:Appcolors().loginhintcolor,
                          selectedposttype==0?Appcolors().gradientcolorsecond:Appcolors().loginhintcolor,
                        ],
                      ),
                    ),
                    Container(
                        height: 6.h,
                        width: 1.5,
                        color: Appcolors().dividercolor),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedposttype = 1;
                        });
                      },
                      child:
                      GradientText(
                        "${StringConstants.scheduled}(180)",
                        style: TextStyle(
                            fontSize: 9.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w400),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ttb,
                        radius: 6,
                        colors: [
                          selectedposttype==1?Appcolors().gradientcolorfirst:Appcolors().loginhintcolor,
                          selectedposttype==1?Appcolors().gradientcolorsecond:Appcolors().loginhintcolor,
                        ],
                      ),
                    ),
                    Container(
                        height: 6.h,
                        width: 1.5,
                        color: Appcolors().dividercolor),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedposttype = 2;
                        });
                      },
                      child:
                      GradientText(
                        "${StringConstants.drafts}(150)",
                        style: TextStyle(
                            fontSize: 9.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w400),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ttb,
                        radius: 6,
                        colors: [
                          selectedposttype==2?Appcolors().gradientcolorfirst:Appcolors().loginhintcolor,
                          selectedposttype==2?Appcolors().gradientcolorsecond:Appcolors().loginhintcolor,
                        ],
                      ),
                    ),
                    Container(
                        height: 6.h,
                        width: 1.5,
                        color: Appcolors().dividercolor),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedposttype = 3;
                        });
                      },
                      child:
                      GradientText(
                        "${StringConstants.tagged}(250)",
                        style: TextStyle(
                            fontSize: 9.sp,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w400),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ttb,
                        radius: 6,
                        colors: [
                          selectedposttype==3?Appcolors().gradientcolorfirst:Appcolors().loginhintcolor,
                          selectedposttype==3?Appcolors().gradientcolorsecond:Appcolors().loginhintcolor,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: 45.w,
                child: CustomDropdownButton2(
                  hint: "Select Item",
                  dropdownItems: postfilters,
                  value: postfiltervalue,
                  dropdownWidth: 45.w,
                  dropdownHeight: 60.h,
                  buttonWidth: 27.w,
                  onChanged: (value) {
                    setState(() {
                      postfiltervalue = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
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
                                padding: EdgeInsets.all(1.5.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Appcolors().chatuserborder),
                                    borderRadius: BorderRadius.circular(2.h)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 4.5.h,
                                              width: 15.w,
                                              child: CachedNetworkImage(
                                                imageUrl: index % 2 == 0
                                                    ? "https://img.freepik.com/free-photo/isolated-shot-pleasant-looking-cheerful-beautiful-brunette-posing-against-pink-wall_273609-20417.jpg"
                                                    : "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 15.w,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 4.5.h,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Appcolors()
                                                          .backgroundcolor,
                                                    ),
                                                  ),
                                                ),
                                                // errorWidget: (context, url, error) => errorWidget,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Elexa Steele",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily: "PulpDisplay",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Appcolors()
                                                          .whitecolor),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "23/04/2023 01:30 am",
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      // fontFamily: "PulpDisplay",
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Appcolors()
                                                          .loginhintcolor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            customButton: Image.asset(
                                              "assets/images/menubtn.png",
                                              height: 4.h,
                                              fit: BoxFit.fill,
                                            ),
                                            items: [
                                              ...MenuItems.firstItems.map(
                                                (item) => DropdownMenuItem<
                                                    CustomMenuItem>(
                                                  value: item,
                                                  child:
                                                      MenuItems.buildItem(item),
                                                ),
                                              ),
                                              const DropdownMenuItem<Divider>(
                                                  enabled: false,
                                                  child: Divider()),
                                              ...MenuItems.secondItems.map(
                                                (item) => DropdownMenuItem<
                                                    CustomMenuItem>(
                                                  value: item,
                                                  child:
                                                      MenuItems.buildItem(item),
                                                ),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              MenuItems.onChanged(context,
                                                  value as CustomMenuItem);
                                              print("Value:-" + value.text);
                                              if (value.text ==
                                                  StringConstants.editpost) {
                                                setState(() {
                                                  editedpostid = index;
                                                });
                                              } else if (value.text ==
                                                  StringConstants.deletepost) {
                                                showdeletealert(context);
                                              }
                                            },
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              width: 160,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Appcolors()
                                                    .bottomnavbgcolor,
                                              ),
                                              elevation: 8,
                                              offset: const Offset(0, 8),
                                            ),
                                            menuItemStyleData:
                                                MenuItemStyleData(
                                              customHeights: [
                                                ...List<double>.filled(
                                                    MenuItems.firstItems.length,
                                                    35),
                                                8,
                                                ...List<double>.filled(
                                                    MenuItems
                                                        .secondItems.length,
                                                    48),
                                              ],
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //     onTap: () {
                                        //       print("Click click");
                                        //       // showMemberMenu();
                                        //     },
                                        //     child: SvgPicture.asset(
                                        //       "assets/images/feedmenubtn.svg",
                                        //       width: 10.w,
                                        //       height: 5.h,
                                        //     ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Feeddetailedpage()));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 30.h,
                                        child: CachedNetworkImage(
                                          imageUrl: index % 2 == 0
                                              ? "https://images.squarespace-cdn.com/content/v1/53cc306ee4b04fd213249899/1657760960280-QKY0G0PHGZBAW4T3K5T9/Boudoir+Photo+Shoot+Salem+Oregon+Boudoir+Photographer.jpg"
                                              : "https://t3.ftcdn.net/jpg/00/81/64/18/360_F_81641867_qNkdJpUrCMQPu7BSnObppnKIXcQy0jPh.jpg",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 15.w,
                                            alignment: Alignment.centerLeft,
                                            height: 4.5.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color:
                                                    Appcolors().backgroundcolor,
                                              ),
                                            ),
                                          ),
                                          // errorWidget: (context, url, error) => errorWidget,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    editedpostid != index
                                        ? Text(
                                            "What are you up to tonight?",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                // fontFamily: "PulpDisplay",
                                                fontWeight: FontWeight.w500,
                                                color: Appcolors().whitecolor),
                                            textAlign: TextAlign.start,
                                          )
                                        : Container(
                                            child: Column(
                                            children: [
                                              TextFormField(
                                                minLines: 3,
                                                maxLines: 3,
                                                cursorColor:
                                                    Appcolors().loginhintcolor,
                                                style: TextStyle(
                                                  color: Appcolors().whitecolor,
                                                  fontSize: 12.sp,
                                                ),
                                                controller:
                                                    postcontentcontoller,
                                                decoration: InputDecoration(
                                                  // prefix: Container(
                                                  //   child: SvgPicture.asset("assets/images/astrickicon.svg",width: 5.w,),
                                                  // ),
                                                  border: InputBorder.none,
                                                  // focusedBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide: BorderSide(
                                                        color: Appcolors()
                                                            .logintextformborder),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide: BorderSide(
                                                        color: Appcolors()
                                                            .logintextformborder),
                                                  ),
                                                  filled: true,
                                                  isDense: true,
                                                  fillColor: Appcolors()
                                                      .messageboxbgcolor,
                                                  hintText: StringConstants
                                                      .writesomething,
                                                  hintStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    // fontFamily: 'PulpDisplay',
                                                    color: Appcolors()
                                                        .loginhintcolor,
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    height: 5.h,
                                                    child: Text(
                                                      StringConstants.update,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily:
                                                              "PulpDisplay",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Appcolors()
                                                              .backgroundcolor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        editedpostid = null;
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 40.w,
                                                      height: 5.h,
                                                      child: Text(
                                                        StringConstants.cancel,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontFamily:
                                                                "PulpDisplay",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Appcolors()
                                                                .whitecolor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      width: 75.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 20.w,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/likeicon.svg"),
                                                Text(
                                                  "121",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      // fontFamily: "PulpDisplay",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Appcolors()
                                                          .loginhintcolor),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 20.w,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/viewsicon.svg"),
                                                Text(
                                                  "1171",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      // fontFamily: "PulpDisplay",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Appcolors()
                                                          .loginhintcolor),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 20.w,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/unlockicon.svg"),
                                                Text(
                                                  "34",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      // fontFamily: "PulpDisplay",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Appcolors()
                                                          .loginhintcolor),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
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
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
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
                    Text(
                      StringConstants.deletediologmessage,
                      style: TextStyle(
                          fontSize: 14.sp,
                          height: 0.2.h,
                          // fontFamily: "PulpDisplay",
                          fontWeight: FontWeight.w500,
                          color: Appcolors().loginhintcolor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Appcolors().deactivatecolor,
                              borderRadius: BorderRadius.circular(10)),
                          width: 40.w,
                          height: 5.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/deleteicon.svg",
                                height: 3.h,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                StringConstants.deletepost,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "PulpDisplay",
                                    fontWeight: FontWeight.w500,
                                    color: Appcolors().whitecolor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        StringConstants.cancel,
                        style: TextStyle(
                            fontSize: 14.sp,
                            height: 0.2.h,
                            // fontFamily: "PulpDisplay",
                            fontWeight: FontWeight.w500,
                            color: Appcolors().whitecolor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ));
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
}
