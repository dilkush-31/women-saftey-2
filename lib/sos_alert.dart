// import 'package:flutter/material.dart';
// import 'package:my_first_project/sos_service.dart';
// import 'sos_service.dart'; // Import your SOSService class

// class SOSActivatedScreen extends StatelessWidget {
//   final String locationUrl;
//   final SOSService sosService = SOSService();

//   SOSActivatedScreen(BuildContext context, String locationUrl1, {
//     Key? key, 
//     required this.locationUrl
//   }) : super(key: key) {
//     // Initialize Twilio when screen is created
//     sosService.initializeTwilio();
//   }

//   get currentLatitude => null;

//   get currentLongitude => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: const Color.fromRGBO(255, 234, 241, 0.84),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'SOS Alert Activated!',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 0.46,
//                     fontFamily: 'Montserrat',
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 24),
//                 Icon(
//                   Icons.warning_rounded,
//                   size: 80,
//                   color: Colors.red[700],
//                 ),
//                 const SizedBox(height: 24),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     'Sending your location to emergency contacts...',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: 0.32,
//                       fontFamily: 'Montserrat',
//                       color: Colors.black87,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       await sosService.sendSOSMessage();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('SOS alert sent successfully!'),
//                           backgroundColor: Colors.green,
//                         ),
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Failed to send SOS: $e'),
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     }
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red[700],
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text(
//                     'Send SOS',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 0.48,
//                       fontFamily: 'Montserrat',
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
