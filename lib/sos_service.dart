// import 'package:flutter/cupertino.dart';
// import 'package:sms_advanced/sms_advanced.dart';  // Import sms_advanced package
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
//
// Future<void> _sendSOSAlert(BuildContext context) async {
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   String locationUrl = "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
//
//   String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
//   if (uid.isEmpty) {
//     Fluttertoast.showToast(msg: "User not authenticated.");
//     return;
//   }
//
//   DocumentSnapshot userDoc = await FirebaseFirestore.instance
//       .collection("users")
//       .doc(uid)
//       .get();
//
//   if (userDoc.exists && userDoc.data() != null) {
//     Map<String, dynamic> contacts = userDoc['emergency_contacts'] ?? {};
//
//     List<String> recipients = contacts.values.map((e) => e.toString()).toList();
//     if (recipients.isEmpty) {
//       Fluttertoast.showToast(msg: "No emergency contacts found!");
//       return;
//     }
//
//     String message = "🚨 SOS ALERT! 🚨\nI need help! My location: $locationUrl";
//
//     try {
//       SmsSender sender = SmsSender();
//
//       // Send SMS to all recipients
//       for (String recipient in recipients) {
//         SmsMessage smsMessage = SmsMessage(recipient, message);
//         sender.sendSms(smsMessage);
//       }
//
//       Fluttertoast.showToast(msg: "SOS alert sent successfully!");
//     } catch (error) {
//       Fluttertoast.showToast(msg: "Failed to send SOS: $error");
//     }
//   } else {
//     Fluttertoast.showToast(msg: "No Emergency Contacts Found!");
//   }
// }
// SOS Feature Implementation in Dart (Flutter)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class SOSService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TwilioFlutter? twilioFlutter;
  bool _isSendingSOS = false; // Prevent sending multiple SOS messages

  // Initialize Twilio
  void initializeTwilio() {
    twilioFlutter = TwilioFlutter(
      accountSid: 'YOUR_TWILIO_SID',
      authToken: 'YOUR_TWILIO_AUTH_TOKEN',
      twilioNumber: 'YOUR_TWILIO_PHONE_NUMBER',
    );
  }

  // Get the current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // Get emergency contacts from Firestore
  Future<List<String>> _getEmergencyContacts() async {
    String uid = _auth.currentUser!.uid;
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('emergencyContacts')
        .get();

    return snapshot.docs
        .map((doc) => doc['phoneNumber'] as String)
        .toList();
  }

  // Send SOS message with location to emergency contacts
  Future<void> sendSOSMessage() async {
    if (_isSendingSOS) {
      return; // Prevent sending multiple SOS messages
    }
    _isSendingSOS = true; // Set flag to true when sending SOS

    try {
      Position position = await _getCurrentLocation();
      List<String> contacts = await _getEmergencyContacts();
      String message =
          'SOS! I need help. My location: https://maps.google.com/?q=${position.latitude},${position.longitude}';

      for (String contact in contacts) {
        await twilioFlutter?.sendSMS(
          toNumber: contact,
          messageBody: message,
        );
      }
    } catch (e) {
      print('Error sending SOS: $e');
    } finally {
      _isSendingSOS = false; // Reset flag after sending SOS
    }
  }

  // Shake detection logic to trigger SOS
  void initializeShakeDetection() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;

      if (acceleration > 50) {
        sendSOSMessage();
      }
    });
  }
}

// Usage:
// Call initializeTwilio() once in initState.
// Bind initializeShakeDetection() when app starts.
// Call sendSOSMessage() when SOS button is pressed.