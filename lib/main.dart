import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sextconfidential/Chatusersscreen.dart';
import 'package:sextconfidential/utils/Appcolors.dart';
import 'package:sextconfidential/utils/StringConstants.dart';
import 'package:sizer/sizer.dart';

import 'Bottomnavigation.dart';
import 'CallsScreen.dart';
import 'Changepassword.dart';
import 'ConvertsationScreen.dart';
import 'Deactivateaccscreen.dart';
import 'Editprofilescreen.dart';
import 'FeedScreen.dart';
import 'Feeddetailedpage.dart';
import 'LoginScreen.dart';
import 'MassmessageScreen.dart';
import 'PayoutInfoScreen.dart';
import 'TimezoneScreen.dart';
import 'UserprofileScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sext Confidential',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: CallsScreen(),
            // home: FeedScreen(),
            // home: UserprofileScreen(),
            // home: ConvertsationScreen(),
            // home: Deactivateaccscreen(),
            // home: Feeddetailedpage(),
            // home: PayoutInfoScreen(),
            // home: Editprofilescreen(),
            // home: Emojipicker(),
            // home: ConvertsationScreen(),
            home: MyHomePage(),
            // Chatusersscreen(),
          );
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          LoginScreen()), (Route<dynamic> route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splashscreen.png",),fit: BoxFit.fill
              )
          ),
        )
    );
  }
}
