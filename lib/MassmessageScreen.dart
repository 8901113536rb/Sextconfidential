import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
      drawer: Sidedrawer.sidedrawer(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolors().bottomnavbgcolor,
        leading: GestureDetector(
          onTap: (){
            _key.currentState!.openDrawer(); //<-- SEE HERE
          },

            child: Center(child: SvgPicture.asset("assets/images/menubtn.svg",))),
        title: Text(StringConstants.massmessages,style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "PulpDisplay",
            fontWeight: FontWeight.w500,
            color: Appcolors().whitecolor),),
      ),
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
                        style: TextStyle(color:Appcolors().loginhintcolor,fontSize: 12.sp,),
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
                    Container(
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
                          image: AssetImage("assets/images/btnbackgroundgradient.png"),
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
                                              Container(
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
}