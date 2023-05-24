import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/Feeddetailedpage.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
import 'package:sextconfidential/utils/Sidedrawer.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class FeedScreen extends StatefulWidget{
  @override
  FeedScreenState createState() => FeedScreenState();

}

class FeedScreenState extends State<FeedScreen>{
  TextEditingController messagecontroller=TextEditingController();
  List<String>posttypes=["Scheduled Post","Save as Draft"];
  List<String>postfilters=[StringConstants.mostrecent,StringConstants.mostsends,StringConstants.mostread,StringConstants.readrate,StringConstants.mostunlocks,StringConstants.mostearnings,];
  String postselectedvalue="Scheduled Post";
  String postfiltervalue=StringConstants.mostrecent;
  bool posttoexplore=false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

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
     appBar: AppBar(
       elevation: 0,
       backgroundColor: Appcolors().bottomnavbgcolor,
       leading: GestureDetector(
         onTap: (){
           _key.currentState!.openDrawer();
         },
           child: Center(child: SvgPicture.asset("assets/images/menubtn.svg",))),
       title: Text(StringConstants.feed,style: TextStyle(
           fontSize: 14.sp,
           fontFamily: "PulpDisplay",
           fontWeight: FontWeight.w500,
           color: Appcolors().whitecolor),),
     ),
     body: Container(
       padding: EdgeInsets.only(left: 3.w,right: 3.w),
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
                   StringConstants.writesomething,
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
                         fillColor: MaterialStateProperty.all(Colors.transparent),
                         overlayColor: MaterialStateProperty.all(Colors.transparent),
                         checkColor: Appcolors().backgroundcolor,
                         activeColor: Colors.transparent,
                         focusColor: Colors.transparent,
                         hoverColor:  Colors.transparent,
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
                         image: AssetImage("assets/images/btnbackgroundgradient.png"),fit: BoxFit.fill
                       ),
                       borderRadius: BorderRadius.circular(10)
                   ),
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
                   borderRadius: BorderRadius.circular(12)
               ),
               padding: EdgeInsets.all(6),
               alignment: Alignment.center,
               height: 5.h,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   GradientText(
                     "${StringConstants.posted}(199)",
                     style: TextStyle(
                         fontSize: 9.sp,
                         // fontFamily: "PulpDisplay",
                         fontWeight: FontWeight.w400),
                     gradientType: GradientType.linear,
                     gradientDirection: GradientDirection.ttb,
                     radius: 6,
                     colors: [
                       Appcolors().gradientcolorfirst,
                       Appcolors().gradientcolorsecond,
                     ],
                   ),
                   Container(
                       height: 6.h,
                       width: 1.5,
                       color: Appcolors().dividercolor
                   ),
                   Text(
                     "${StringConstants.scheduled}(180)",
                     style: TextStyle(
                         fontSize: 9.sp,
                         // fontFamily: "PulpDisplay",
                         fontWeight: FontWeight.w400,
                         color: Appcolors().loginhintcolor),
                     textAlign: TextAlign.center,
                   ),
                   Container(
                       height: 6.h,
                       width: 1.5,
                       color: Appcolors().dividercolor
                   ),
                   Text(
                     "${StringConstants.drafts}(150)",
                     style: TextStyle(
                         fontSize: 9.sp,
                         // fontFamily: "PulpDisplay",
                         fontWeight: FontWeight.w400,
                         color: Appcolors().loginhintcolor),
                     textAlign: TextAlign.center,
                   ),
                   Container(
                       height: 6.h,
                       width: 1.5,
                       color: Appcolors().dividercolor
                   ),
                   Text(
                     "${StringConstants.tagged}(250)",
                     style: TextStyle(
                         fontSize: 9.sp,
                         // fontFamily: "PulpDisplay",
                         fontWeight: FontWeight.w400,
                         color: Appcolors().loginhintcolor),
                     textAlign: TextAlign.center,
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
             SizedBox(height: 1.h,),
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
                                             child: CachedNetworkImage(
                                               imageUrl:index%2==0?"https://img.freepik.com/free-photo/isolated-shot-pleasant-looking-cheerful-beautiful-brunette-posing-against-pink-wall_273609-20417.jpg"
                                               :"https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
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
                                                 "Elexa Steele",
                                                 style: TextStyle(
                                                     fontSize: 14.sp,
                                                     fontFamily: "PulpDisplay",
                                                     fontWeight: FontWeight.w400,
                                                     color: Appcolors().whitecolor),
                                                 textAlign: TextAlign.center,
                                               ),
                                               Text(
                                                 "23/04/2023 01:30 am",
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
                                       GestureDetector(
                                         onTap: (){
                                           print("Click click");
                                           showMemberMenu();
                                         },
                                           child: SvgPicture.asset("assets/images/feedmenubtn.svg",width: 10.w,height: 5.h,))
                                     ],
                                   ),
                                   SizedBox(
                                     height: 1.5.h,
                                   ),
                                   GestureDetector(
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => Feeddetailedpage()));
                                     },
                                     child: Container(
                                       width:double.infinity,
                                       height: 30.h,
                                       child: CachedNetworkImage(
                                         imageUrl:index%2==0?"https://images.squarespace-cdn.com/content/v1/53cc306ee4b04fd213249899/1657760960280-QKY0G0PHGZBAW4T3K5T9/Boudoir+Photo+Shoot+Salem+Oregon+Boudoir+Photographer.jpg"
                                             :"https://t3.ftcdn.net/jpg/00/81/64/18/360_F_81641867_qNkdJpUrCMQPu7BSnObppnKIXcQy0jPh.jpg",
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
                                   ),
                                   SizedBox(
                                     height: 2.h,
                                   ),
                                   Text(
                                     "What are you up to tonight?",
                                     style: TextStyle(
                                         fontSize: 12.sp,
                                         // fontFamily: "PulpDisplay",
                                         fontWeight: FontWeight.w500,
                                         color: Appcolors().whitecolor),
                                     textAlign: TextAlign.start,
                                   ),
                                   SizedBox(
                                     height: 2.h,
                                   ),
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
                                                 "121",
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
                                                 "1171",
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
                                                 "34",
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
  Future<Container> showMemberMenu() async {
    return Container(
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
    );
  }
}