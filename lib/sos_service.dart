// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// class SOSService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool _isSendingSOS = false;

//   // Get current location
//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied');
//       }
//     }

//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high
//     );
//   }

//   // Send SOS email with location to emergency contacts
//   Future<void> sendSOSMessage() async {
//     if (_isSendingSOS) return;
//     _isSendingSOS = true;

//     try {
//       // Get current user
//       String uid = _auth.currentUser?.uid ?? "";
//       if (uid.isEmpty) throw Exception('User not authenticated');

//       // Get user's emergency contacts
//       DocumentSnapshot userDoc = await _firestore
//           .collection("users")
//           .doc(uid)
//           .get();

//       if (!userDoc.exists) throw Exception('User document not found');
      
//       Map<String, dynamic> contacts = userDoc['emergency_contacts'] ?? {};
//       if (contacts.isEmpty) throw Exception('No emergency contacts found');

//       // Get current location
//       Position position = await _getCurrentLocation();
//       String locationUrl = 
//           "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";

//       // Email configuration
//       final smtpServer = gmail('your-app-email@gmail.com', 'your-app-specific-password');

//       // Prepare email message
//       final message = Message()
//         ..from = Address('your-app-email@gmail.com', 'EmpowerMe Safety Alert')
//         ..subject = '🚨 EMERGENCY SOS ALERT!'
//         ..html = '''
//           <h2>EMERGENCY SOS ALERT!</h2>
//           <p>Someone you know needs immediate help!</p>
//           <p><strong>Current Location:</strong> <a href="$locationUrl">Click here to view location</a></p>
//           <p>Please respond immediately!</p>
//           <br>
//           <p>This is an automated alert from EmpowerMe Safety App.</p>
//         ''';

//       // Send email to all emergency contacts
//       for (var contact in contacts.entries) {
//         try {
//           message.recipients = [contact.value];
//           await send(message, smtpServer);
//         } catch (e) {
//           print('Error sending email to ${contact.key}: $e');
//         }
//       }

//       // Log the SOS event in Firestore
//       await _firestore.collection('sos_alerts').add({
//         'user_id': uid,
//         'timestamp': FieldValue.serverTimestamp(),
//         'location': GeoPoint(position.latitude, position.longitude),
//         'status': 'sent',
//         'recipients': contacts.values.toList(),
//       });

//     } catch (e) {
//       print('Error sending SOS: $e');
//       rethrow;
//     } finally {
//       _isSendingSOS = false;
//     }
//   }

//   // Shake detection logic to trigger SOS
//   void initializeShakeDetection() {
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       double acceleration =
//           event.x * event.x + event.y * event.y + event.z * event.z;

//       if (acceleration > 50) {
//         sendSOSMessage();
//       }
//     });
//   }
// }

// // Usage:
// // Bind initializeShakeDetection() when app starts.
// // Call sendSOSMessage() when SOS button is pressed.