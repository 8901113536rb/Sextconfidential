// import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:path_provider/path_provider.dart';
// import 'package:record_mp3/record_mp3.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
// class Recorddemo extends StatefulWidget {
//   @override
//   RecorddemoState createState() => RecorddemoState();
// }
//
// class RecorddemoState extends State<Recorddemo> {
//   String statusText = "";
//   bool isComplete = false;
//   String recordingTime = '0:0'; // to store value
//   bool isRecording = false;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child: GestureDetector(
//                   child: Container(
//                     height: 48.0,
//                     decoration: BoxDecoration(color: Colors.red.shade300),
//                     child: Center(
//                       child: Text(
//                         'start',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   onTap: () async {
//                     startRecord();
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   child: Container(
//                     height: 48.0,
//                     decoration: BoxDecoration(color: Colors.blue.shade300),
//                     child: Center(
//                       child: Text(
//                         RecordMp3.instance.status == RecordStatus.PAUSE
//                             ? 'resume'
//                             : 'pause',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//                     pauseRecord();
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   child: Container(
//                     height: 48.0,
//                     decoration: BoxDecoration(color: Colors.green.shade300),
//                     child: Center(
//                       child: Text(
//                         'stop',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//                     stopRecord();
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: Text(
//               statusText,
//               style: TextStyle(color: Colors.red, fontSize: 20),
//             ),
//           ),
//           GestureDetector(
//             behavior: HitTestBehavior.opaque,
//             onTap: () {
//               play();
//             },
//             child: Container(
//               margin: EdgeInsets.only(top: 30),
//               alignment: AlignmentDirectional.center,
//               width: 100,
//               height: 50,
//               child: isComplete && recordFilePath != null
//                   ? Text(
//                 "play",
//                 style: TextStyle(color: Colors.red, fontSize: 20),
//               )
//                   : Container(),
//             ),
//           ),
//           Text(
//             recordingTime,
//             style: TextStyle(color: Colors.red, fontSize: 20),
//           )
//         ]),
//       ),
//     );
//   }
//
//   Future<bool> checkPermission() async {
//     if (!await Permission.microphone.isGranted) {
//       PermissionStatus status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   void startRecord() async {
//     bool hasPermission = await checkPermission();
//     if (hasPermission) {
//       statusText = "Recording...";
//       recordFilePath = await getFilePath();
//       isComplete = false;
//       setState(() {
//         print("Recording start");
//         recordTime();
//         isRecording=true;
//       });
//       RecordMp3.instance.start(recordFilePath!, (type) {
//         statusText = "Record error--->$type";
//       });
//       print("Recording path:-"+recordFilePath.toString());
//     } else {
//       statusText = "No microphone permission";
//     }
//     setState(() {});
//   }
//
//   void pauseRecord() {
//     if (RecordMp3.instance.status == RecordStatus.PAUSE) {
//       bool s = RecordMp3.instance.resume();
//       if (s) {
//         statusText = "Recording...";
//         setState(() {});
//       }
//     } else {
//       bool s = RecordMp3.instance.pause();
//       if (s) {
//         statusText = "Recording pause...";
//         setState(() {});
//       }
//     }
//   }
//
//   void stopRecord() {
//     bool s = RecordMp3.instance.stop();
//     if (s) {
//       statusText = "Record complete";
//       isComplete = true;
//       setState(() {
//         isRecording=false;
//       });
//     }
//   }
//
//   void resumeRecord() {
//     bool s = RecordMp3.instance.resume();
//     if (s) {
//       statusText = "Recording...";
//       setState(() {});
//     }
//   }
//
//   String? recordFilePath;
//
//   void play() {
//     if (recordFilePath != null && File(recordFilePath!).existsSync()) {
//       AudioPlayer audioPlayer = AudioPlayer();
//       // audioPlayer.play(recordFilePath!, isLocal: true);
//     }
//   }
//
//   int i = 0;
//
//   Future<String> getFilePath() async {
//     Directory storageDirectory = await getApplicationDocumentsDirectory();
//     String sdPath = storageDirectory.path + "/record";
//     var d = Directory(sdPath);
//     if (!d.existsSync()) {
//       d.createSync(recursive: true);
//     }
//     return sdPath + "/test_${i++}.mp3";
//   }
//   void recordTime() {
//     // setState(() {
//       var startTime = DateTime.now();
//       Timer.periodic(const Duration(seconds: 1), (Timer t) {
//         var diff = DateTime.now().difference(startTime);
//         setState((){
//           recordingTime =
//           '${diff.inHours < 60 ? diff.inHours : 0}:${diff.inMinutes < 60 ? diff.inMinutes : 0}:${diff.inSeconds < 60 ? diff.inSeconds : 0}';
//         });
//         print(recordingTime);
//
//         if (!isRecording) {
//           t.cancel(); //cancel function calling
//         }
//       });
//     // });
//   }
// }