import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class Feeddetailedpage extends StatefulWidget{
  @override
  FeeddetailedpageState createState() => FeeddetailedpageState();

}

class FeeddetailedpageState extends State<Feeddetailedpage>{
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
                      child: CachedNetworkImage(
                        imageUrl:"https://img.freepik.com/free-photo/isolated-shot-pleasant-looking-cheerful-beautiful-brunette-posing-against-pink-wall_273609-20417.jpg",
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
                SvgPicture.asset("assets/images/feedmenubtn.svg",width: 10.w,height: 5.h,)
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              width:double.infinity,
              height: 50.h,
              child: CachedNetworkImage(
                imageUrl:"https://images.squarespace-cdn.com/content/v1/53cc306ee4b04fd213249899/1657760960280-QKY0G0PHGZBAW4T3K5T9/Boudoir+Photo+Shoot+Salem+Oregon+Boudoir+Photographer.jpg",
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
    );
  }
}