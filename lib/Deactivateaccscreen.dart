import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/LoginScreen.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

class Deactivateaccscreen extends StatefulWidget{
  @override
  DeactivateaccscreenState createState() => DeactivateaccscreenState();


}

class DeactivateaccscreenState extends State<Deactivateaccscreen>{
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController notecontroller=TextEditingController();
  List<String>items=["Not Sure Why","Don't like","Missing features"];
  String dropdownvalue="Not Sure Why";
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
        title: Text(StringConstants.deactivateacccount,style: TextStyle(
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
              Text(StringConstants.reasonforleaving,style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "PulpDisplay",
                  fontWeight: FontWeight.w500,
                  color: Appcolors().loginhintcolor),),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 7.h,
                width: 94.w,
                child: CustomDropdownButton2(
                  buttonDecoration: BoxDecoration(
                      color: Appcolors().backgroundcolor,
                      border: Border.all(color: Appcolors().logintextformborder),
                    borderRadius: BorderRadius.circular(15)
                  ),
                 dropdownDecoration: BoxDecoration(
                    color: Appcolors().backgroundcolor,
                    border: Border.all(color: Appcolors().logintextformborder),
                     borderRadius: BorderRadius.circular(15)
                 ),
                  dropdownWidth: 94.w,
                  hint: 'Select Item',
                  dropdownItems: items,
                  value: dropdownvalue,
                  onChanged: (value) {
                    setState(() {
                      dropdownvalue = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                child: TextFormField(
                  maxLines: 4,
                  minLines: 4,
                  cursorColor: Appcolors().loginhintcolor,
                  style: TextStyle(color:Appcolors().whitecolor,fontSize: 12.sp,),
                  controller: notecontroller,
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
                    hintText:
                    StringConstants.reasonofleavening,
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
                height: 3.h,
              ),
              GestureDetector(
                onTap: (){
                  showalertdialog(context);
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Appcolors().deactivatecolor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: 60.w,
                    height: 5.h,
                    child:   Text(StringConstants.deactivateaccount,style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "PulpDisplay",
                        fontWeight: FontWeight.w500,
                        color: Appcolors().whitecolor),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
  Future<void> showalertdialog(BuildContext context) {
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
                height: 30.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/alerticon.svg",height: 4.h,),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(StringConstants.alertdialogmessage,style: TextStyle(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Appcolors().deactivatecolor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: 60.w,
                          height: 5.h,
                          child:   Text(StringConstants.deactivateaccount,style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "PulpDisplay",
                              fontWeight: FontWeight.w500,
                              color: Appcolors().whitecolor),),
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
}