import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sextconfidential/ConvertsationScreen.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/CustomDropdownButton2.dart';
import 'package:sextconfidential/utils/Sidedrawer.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class Chatusersscreen extends StatefulWidget{
  @override
  ChatusersscreenState createState() => ChatusersscreenState();

}

class ChatusersscreenState extends State<Chatusersscreen>{
  TextEditingController searchcontroller=TextEditingController();
  List<String>chattype=["Most Recent","Unread","Recently Active","New Clients","Favourite","Credits","Top Spenders","Hidden","Unanswered"];
  String chatselectedtype="Most Recent";
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

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
        title: Text(StringConstants.messages,style: TextStyle(
            fontSize: 14.sp,
            fontFamily: "PulpDisplay",
            fontWeight: FontWeight.w500,
            color: Appcolors().whitecolor),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 2.w,right: 2.w),
        color: Appcolors().backgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              child: TextFormField(
                cursorColor: Appcolors().loginhintcolor,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w300,
                  fontFamily: "PulpDisplay",
                  fontSize: 12.sp,
                  color: Appcolors().loginhintcolor,
                ),
                controller: searchcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/searchicon.svg",
                      color: Appcolors().loginhintcolor,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width / 100) * 5,
                      right: (MediaQuery.of(context).size.width / 100) * 5,
                      //  top: (MediaQuery.of(context).size.height / 100) * 1,
                    ),
                  ),
                  // focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Appcolors().bottomnavbgcolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Appcolors().bottomnavbgcolor),
                  ),
                  filled: true,
                  fillColor: Appcolors().bottomnavbgcolor,
                  hintText: StringConstants.search,
                  hintStyle: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w300,
                    fontFamily: "PulpDisplay",
                    fontSize: 12.sp,
                    color: Appcolors().loginhintcolor,
                  ),
                ),
                onChanged: (value) {

                },
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: 50.w,
              child: CustomDropdownButton2(
                hint: chatselectedtype,
                dropdownItems: chattype,
                value: chatselectedtype,
                dropdownWidth: 50.w,
                buttonWidth: 50.w,
                dropdownHeight: 60.h,
                onChanged: (value) {
                  setState(() {
                    chatselectedtype = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
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
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConvertsationScreen()));
                          },
                                  child: Container(
                                    padding: EdgeInsets.all(1.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Appcolors().chatuserborder),
                                      borderRadius: BorderRadius.circular(2.h)
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                            imageUrl: index%2==0?"https://c4.wallpaperflare.com/wallpaper/702/785/274/eiza-gonzalez-music-celebrities-girls-wallpaper-thumb.jpg":"https://www.flickonclick.com/wp-content/uploads/2022/09/Esha-Gupta-Hot-and-Sexy.jpg",
                                            imageBuilder: (context,
                                                imageProvider) =>
                                                Container(
                                                  width: 14.w,
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  height: 7.h,
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
                                          width: 5.w,
                                        ),
                                        Container(
                                          width: 72.w,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width:30.w,
                                                    child: Text(index%2==0?"Michael":"Gabriel Greene",style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontFamily: "PulpDisplay",
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: Appcolors().whitecolor),),
                                                  ),
                                                  GradientText(
                                                    "01:01 PM",
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontFamily: "PulpDisplay",
                                                        fontWeight: FontWeight.w400),
                                                    gradientType: GradientType.linear,
                                                    gradientDirection: GradientDirection.ttb,
                                                    radius: 6,
                                                    colors: [
                                                      Appcolors().gradientcolorfirst,
                                                      Appcolors().gradientcolorsecond,
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width:60.w,
                                                    child: Text(index%2==0?"Hello...":"What have you been up to",style: TextStyle(
                                                        fontSize: 12.sp,
                                                        // fontFamily: "PulpDisplay",
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        color: Appcolors().loginhintcolor),),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(1.h),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Appcolors().gradientcolorfirst,
                                                            Appcolors().gradientcolorsecond,
                                                          ],
                                                          begin: Alignment.topCenter,
                                                          end: Alignment.bottomCenter,
                                                          stops: [0.0, 1.0],
                                                          tileMode: TileMode.clamp),
                                                  ),
                                                    child: Text("2",style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontFamily: "PulpDisplay",
                                                        fontWeight: FontWeight.w400,
                                                        color: Appcolors().blackcolor),),

                                                  )

                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
                ))

          ],
        ),
      ),
    );
  }
}