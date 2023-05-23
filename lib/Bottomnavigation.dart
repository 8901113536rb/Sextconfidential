import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/Sidedrawer.dart';
import 'package:sizer/sizer.dart';

import 'CallsScreen.dart';
import 'Chatusersscreen.dart';
import 'FeedScreen.dart';
import 'MassmessageScreen.dart';

class Bottomnavigation extends StatefulWidget{
  @override
  BottomnavigationState createState() => BottomnavigationState();

}

class BottomnavigationState extends State<Bottomnavigation>{
  int selectedindex=0;
  String? token;
  final pages = [
    Chatusersscreen(),
    MassmessageScreen(),
    FeedScreen(),
    CallsScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidedrawer(),
      body: pages[selectedindex],
      bottomNavigationBar: Container(
        height: 7.h,
        color: Appcolors().bottomnavbgcolor,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  selectedindex=0;
                });
              },
              child:
              selectedindex==0?
              Image.asset("assets/images/chatselectedicon.png",height:3.h):
              Image.asset("assets/images/messagesunselec.png",height:3.h,),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  selectedindex=1;
                });
              },
              child:
              selectedindex==1?
              Image.asset("assets/images/massmessageselect.png",height:3.h):
              Image.asset("assets/images/massmessageunselect.png",height:3.h),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  selectedindex=2;
                });
              },
              child:
              selectedindex==2?
              Image.asset("assets/images/feedselecticon.png",height:3.h):
              Image.asset("assets/images/feedunselecticon.png",height:3.h),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  selectedindex=3;
                });
              },
              child:
              selectedindex==3?
              Image.asset("assets/images/callselecticon.png",height:3.h):
              Image.asset("assets/images/callunselecticon.png",height:3.h),
            ),
          ],
        ),
      ),
    );
  }
}