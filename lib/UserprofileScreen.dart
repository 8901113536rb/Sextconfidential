import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

import 'Bottomnavigation.dart';

class UserprofileScreen extends StatefulWidget{
  @override
  UserprofileScreenState createState() => UserprofileScreenState();

}

class UserprofileScreenState extends State<UserprofileScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolors().bottomnavbgcolor,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 3.w,right: 3.w),
        color: Appcolors().backgroundcolor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                  padding: EdgeInsets.only(left: 3.5.w, right: 3.5.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Appcolors().profileboxcolor,
                    borderRadius: BorderRadius.circular(10)
                ),
                // height: 40.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(0.6.h),
                      decoration:
                      BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.white,
                          gradient: LinearGradient(
                              colors: [
                                Appcolors().gradientcolorsecond,
                                Appcolors().gradientcolorfirst,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight
                          )
                      ),
                      child: CachedNetworkImage(
                        imageUrl:"https://c4.wallpaperflare.com/wallpaper/702/785/274/eiza-gonzalez-music-celebrities-girls-wallpaper-thumb.jpg",
                        imageBuilder: (context,
                            imageProvider) =>
                            Container(
                              width: 23.w,
                              alignment: Alignment
                                  .centerLeft,
                              height: 9.5.h,
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
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Michael",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "PulpDisplay",
                          fontWeight: FontWeight.w400,
                          color: Appcolors().whitecolor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      StringConstants.onlinenow,
                      style: TextStyle(
                          fontSize: 9.sp,
                          // fontFamily: "PulpDisplay",
                          fontWeight: FontWeight.w500,
                          color: Appcolors().onlinecolor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 5.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/btnbackgroundgradient.png"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(1.5.h),
                        ),
                        child: Text(
                          StringConstants.block,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w500,
                              color: Appcolors().blackcolor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 5.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                              color: Appcolors().profileboxcolor,
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Appcolors().loginhintcolor)
                          ),
                          child: Text(
                            StringConstants.hide,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w500,
                                color: Appcolors().loginhintcolor),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 5.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                              color: Appcolors().profileboxcolor,
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Appcolors().loginhintcolor)
                          ),
                          child: Text(
                            StringConstants.report,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w500,
                                color: Appcolors().loginhintcolor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                StringConstants.media,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "PulpDisplay",
                    fontWeight: FontWeight.w500,
                    color: Appcolors().whitecolor),
              ),
              SizedBox(
                height: 2.h,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: 320,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7, crossAxisCount: 3),
                  itemCount: 20,
                  itemBuilder: (BuildContext ctx, index) {
                    return
                      AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 30,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl:index%2==0?"https://images.squarespace-cdn.com/content/v1/53cc306ee4b04fd213249899/1657760960280-QKY0G0PHGZBAW4T3K5T9/Boudoir+Photo+Shoot+Salem+Oregon+Boudoir+Photographer.jpg"
                                      :"https://t3.ftcdn.net/jpg/00/81/64/18/360_F_81641867_qNkdJpUrCMQPu7BSnObppnKIXcQy0jPh.jpg",
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 25.w,
                                    alignment: Alignment.centerLeft,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>   Center(
                                    child:CircularProgressIndicator(strokeWidth: 2,color: Appcolors().backgroundcolor,),

                                  ),
                                  // errorWidget: (context, url, error) => errorWidget,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                  })


            ],
          ),
        )
      ),

    );
  }
}