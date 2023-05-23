import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class Changepassword extends StatefulWidget{
  @override
  ChangepasswordState createState() => ChangepasswordState();


}

class ChangepasswordState extends State<Changepassword>{
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController newpasswordcontroller=TextEditingController();
  TextEditingController confirmnewpasswordcontroller=TextEditingController();

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
        title: Text(StringConstants.changepassword,style: TextStyle(
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
              Text(StringConstants.deactivatemesaage,style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "PulpDisplay",
                  fontWeight: FontWeight.w500,
                  color: Appcolors().loginhintcolor),),
              SizedBox(
                height: 2.h,
              ),
              Container(
                child: TextFormField(
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    // suffix: Container(
                    //   child: SvgPicture.asset("assets/images/verifiedicon.svg",width: 5.w,),
                    // ),
                    suffixIcon: Icon(Icons.verified,color: Appcolors().verifiedicon,),
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
                    StringConstants.oldpassword,
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
                      return "Please enter Old Password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(StringConstants.passwordnote,style: TextStyle(
                  fontSize: 11.sp,
                  // fontFamily: "PulpDisplay",
                  fontWeight: FontWeight.w500,
                  color: Appcolors().whitecolor),),
              SizedBox(
                height: 4.h,
              ),
              Text(StringConstants.enternewpassword,style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "PulpDisplay",
                  fontWeight: FontWeight.w500,
                  color: Appcolors().loginhintcolor),),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: TextFormField(
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: newpasswordcontroller,
                  obscureText: true,
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
                    StringConstants.newpassword,
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
                      return "Please enter new Password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(StringConstants.confirmnewpassword,style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "PulpDisplay",
                  fontWeight: FontWeight.w500,
                  color: Appcolors().loginhintcolor),),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: TextFormField(
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: confirmnewpasswordcontroller,
                  obscureText: true,
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
                    StringConstants.confirmnewpassword,
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
                      return "Please enter Confirm New Password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
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
                      StringConstants.changepassword,
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
        ),
      ),
    );
  }
}