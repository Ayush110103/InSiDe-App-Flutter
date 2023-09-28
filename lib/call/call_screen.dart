// import 'dart:math' as math;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//
// final String localUserId=math.Random().nextInt(1000000000).toString();
// class CallScreen extends StatefulWidget {
//   const CallScreen({super.key});
//
//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }
//
// class _CallScreenState extends State<CallScreen> {
//
//   TextEditingController CallIdTextCtrl=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: TextField(
//                     controller: CallIdTextCtrl,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Call Id',
//                     ),
//
//                 ),
//               ),
//               SizedBox(width: 20),
//               FloatingActionButton(
//                 onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context){return CallPage())
//                 },
//                 child: Icon(Icons.call),
//               ),
//             ],
//
//
//           ),
//         )
//         ),
//     );
//   }
// }
//
//
//   class CallPage extends StatelessWidget {
//   const CallPage({Key? key, required this.callID}) : super(key: key);
//   final String callID;
//
//   @override
//   Widget build(BuildContext context) {
//   return ZegoUIKitPrebuiltCall(
//   appID: y, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//   appSign: yourAppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//   userID: 'user_id',
//   userName: 'user_name',
//   callID: callID,
//   // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//   config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall())
//   ..onOnlySelfInRoom = () => Navigator.of(context).pop(),
//   );
//
//   }
//   }
// }
// }