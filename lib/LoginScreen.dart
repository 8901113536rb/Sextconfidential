import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sextconfidential/Bottomnavigation.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  bool passwordobsecure=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Appcolors().backgroundcolor,
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    Container(
                      width: double.infinity,
                      height: 30.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/loginbgtop.png"),fit: BoxFit.fill)),
                      child: Center(
                          child: new Image.asset(
                        "assets/images/logo.png",
                        height: 12.h,
                      )),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          GradientText(
                            StringConstants.welcome,
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
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            StringConstants.logintoyouraccount,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "PulpDisplay",
                                fontWeight: FontWeight.w500,
                                color: Appcolors().whitecolor),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3.w, right: 3.w),
                            child: TextFormField(
                              cursorColor: Appcolors().loginhintcolor,
                              style: TextStyle(color:Appcolors().loginhintcolor,fontSize: 12.sp,),
                              controller: emailcontoller,
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
                                      StringConstants.emailaddressorphoneno,
                                  hintStyle: TextStyle(
                                    decoration: TextDecoration.none,
                                    // fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    // fontFamily: 'PulpDisplay',
                                    color: Appcolors().loginhintcolor,
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 4.w),
                                    child: SvgPicture.asset(
                                        "assets/images/astrickicon.svg"),
                                  )),
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3.5.w, right: 3.5.w),
                            child: TextFormField(
                              style: TextStyle(color:Appcolors().loginhintcolor,fontSize: 12.sp,),
                              controller: passwordcontoller,
                              obscureText: passwordobsecure,
                              cursorColor: Appcolors().loginhintcolor,
                              decoration: InputDecoration(
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
                                  hintText: StringConstants.password,
                                  hintStyle: TextStyle(
                                    decoration: TextDecoration.none,
                                    // fontWeight: FontWeight.w200,
                                    fontSize: 12.sp,
                                    // fontFamily: 'PulpDisplay',
                                    color: Appcolors().loginhintcolor,
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 4.w),
                                    child: SvgPicture.asset(
                                        "assets/images/lockicon.svg"),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(passwordobsecure==true){
                                          passwordobsecure=false;
                                        }else{
                                          passwordobsecure=true;
                                        }
                                        print("Visibility true");
                                      });
                                    },
                                    child: Icon(
                                      !passwordobsecure?
                                      Icons.visibility
                                      :
                                      Icons.visibility_off_outlined,
                                      color: Appcolors().loginhintcolor,
                                    ),
                                  )
                                  // suffixIcon: Icon(Icons.visibility)
                                  ),
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 3.5.w, right: 3.5.w),
                              height: 6.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/btnbackgroundgradient.png"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(1.5.h),
                              ),
                              child: Text(
                                StringConstants.login,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "PulpDisplay",
                                    fontWeight: FontWeight.w500,
                                    color: Appcolors().blackcolor),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
