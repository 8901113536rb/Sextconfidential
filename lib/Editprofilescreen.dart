import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class Editprofilescreen extends StatefulWidget{
  @override
  EditprofilescreenState createState() => EditprofilescreenState();

}

class EditprofilescreenState extends State<Editprofilescreen>{
  TextEditingController namecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
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
        title: Text(StringConstants.editprofile,style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "PulpDisplay",
            fontWeight: FontWeight.w500,
            color: Appcolors().whitecolor),),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 3.w,right: 3.w),
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedNetworkImage(
                      alignment: Alignment.topCenter,
                      imageUrl:"https://c4.wallpaperflare.com/wallpaper/702/785/274/eiza-gonzalez-music-celebrities-girls-wallpaper-thumb.jpg",
                      imageBuilder: (context,
                          imageProvider) =>
                          Container(
                            width: 30.w,
                            alignment: Alignment
                                .centerLeft,
                            height: 15.h,
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
                    Container(
                      margin: EdgeInsets.only(bottom: 1.h,right: 1.w),
                      padding: EdgeInsets.all(0.8.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [
                                Appcolors().gradientcolorsecond,
                                Appcolors().gradientcolorfirst,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight
                          )
                      ),
                      child: SvgPicture.asset("assets/images/cameraicon.svg",color: Colors.black,height: 2.h,width: 2.w,)
                    )
                  ],
                )
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(StringConstants.name,style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w400,
                      color: Appcolors().loginhintcolor),),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),  
              Container(
                child: TextFormField(
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: namecontroller,
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
                    fillColor: Appcolors().backgroundcolor,
                    hintText:
                    "Elexa Steele",
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
                      return "Please Model Name!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(StringConstants.bio,style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w400,
                      color: Appcolors().loginhintcolor),),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: TextFormField(
                  minLines: 3,
                  maxLines: 3,
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: biocontroller,
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
                    fillColor: Appcolors().backgroundcolor,
                    hintText:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy.",
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
                      return "Please Model Bio!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(StringConstants.emailaddress,style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w400,
                      color: Appcolors().loginhintcolor),),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: TextFormField(
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: emailcontroller,
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
                    fillColor: Appcolors().backgroundcolor,
                    hintText:
                    "elexasteele@gmail.com",
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
                      return "Please enter Email Address";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(StringConstants.phonenumber  ,style: TextStyle(
                      fontSize: 12.sp,
                      // fontFamily: "PulpDisplay",
                      fontWeight: FontWeight.w400,
                      color: Appcolors().loginhintcolor),),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: TextFormField(
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: phonenumbercontroller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.verified_rounded,color: Appcolors().gradientcolorfirst,size: 3.h,),
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
                    fillColor: Appcolors().backgroundcolor,
                    hintText:
                    "+1 2345 7890",
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
                      return "Please enter Email Address";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/btnbackgroundgradient.png"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(1.5.h),
                    ),
                    child: Text(
                      StringConstants.savechanges,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "PulpDisplay",
                          fontWeight: FontWeight.w500,
                          color: Appcolors().blackcolor),
                    ),
                  ),
                ),
              )
            ],
        ),
          )
      ),

    );
  }
}