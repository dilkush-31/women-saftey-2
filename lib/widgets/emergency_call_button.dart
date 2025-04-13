import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmergencyCallButton extends StatefulWidget {
  const EmergencyCallButton({
    Key? key,
  }) : super(key: key);

  @override
  State<EmergencyCallButton> createState() => _EmergencyCallButtonState();
}

class _EmergencyCallButtonState extends State<EmergencyCallButton> {
  Map<String, dynamic> _emergencyContacts = {};
  bool _isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadEmergencyContacts();
  }

  Future<void> _loadEmergencyContacts() async {
    if (_auth.currentUser != null) {
      try {
        DocumentSnapshot userDoc = await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _emergencyContacts = userDoc['emergency_contacts'] ?? {};
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Error loading emergency contacts: $e');
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _makeEmergencyCall(String phone) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $phone';
      }
    } catch (e) {
      print('Error making emergency call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Emergency Contacts',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              content: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _emergencyContacts.isEmpty
                      ? Text(
                          'No emergency contacts found. Please add emergency contacts first.',
                          style: GoogleFonts.poppins(),
                        )
                      : SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _emergencyContacts.length,
                            itemBuilder: (context, index) {
                              String name = _emergencyContacts.keys.elementAt(index);
                              String phone = _emergencyContacts[name];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red[100],
                                  child: Icon(Icons.person, color: Colors.red[700]),
                                ),
                                title: Text(
                                  name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  phone,
                                  style: GoogleFonts.poppins(),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.call, color: Colors.red[700]),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _makeEmergencyCall(phone);
                                  },
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  _makeEmergencyCall(phone);
                                },
                              );
                            },
                          ),
                        ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.emergency, size: 24),
        label: Text(
          'Emergency Call',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
} 