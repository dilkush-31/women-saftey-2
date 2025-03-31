import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddClosePeoplePage extends StatefulWidget {
  const AddClosePeoplePage({Key? key}) : super(key: key);

  @override
  _AddClosePeoplePageState createState() => _AddClosePeoplePageState();
}

class _AddClosePeoplePageState extends State<AddClosePeoplePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // Add the contact to Firestore
  Future<void> addEmergencyContact() async {
    String name = _nameController.text;
    String phoneNumber = _phoneController.text;

    if (name.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and phone number')),
      );
      return;
    }

    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (uid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    try {
      // Reference to the current user's document
      DocumentReference userDocRef = FirebaseFirestore.instance.collection("users").doc(uid);

      // Get the current emergency contacts field (if exists)
      DocumentSnapshot userDocSnapshot = await userDocRef.get();
      if (userDocSnapshot.exists) {
        // Get the emergency contacts map
        Map<String, dynamic> emergencyContacts = userDocSnapshot['emergency_contacts'] ?? {};

        // Add new contact to the map
        emergencyContacts[name] = phoneNumber;

        // Update the Firestore document
        await userDocRef.update({
          'emergency_contacts': emergencyContacts,
        });
      } else {
        // If document does not exist, create it and add emergency contacts
        await userDocRef.set({
          'emergency_contacts': {
            name: phoneNumber,
          },
        });
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name has been added as a close friend!')),
      );

      // Clear the input fields after adding the contact
      _nameController.clear();
      _phoneController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Close People')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Icon and Title Section
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Image.network(
                          'https://cdn.builder.io/api/v1/image/assets/TEMP/c5ce82a0d0ffc0e017631ebd6754f0e1bc6c5b9e',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Add Close People',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: isMobile ? 20 : (isTablet ? 24 : 28),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Name Input Section
                  _buildInputField('Enter Name:', isMobile, isTablet, controller: _nameController),

                  // Phone Number Input Section
                  _buildInputField('Enter Phone Number:', isMobile, isTablet, controller: _phoneController, isPhone: true),

                  // Add Button
                  Container(
                    width: isMobile ? 130 : (isTablet ? 150 : 166),
                    height: isMobile ? 50 : (isTablet ? 56 : 62),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF69B4),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: addEmergencyContact,
                        borderRadius: BorderRadius.circular(30),
                        child: Center(
                          child: Text(
                            'Add +',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: isMobile ? 18 : 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(String label, bool isMobile, bool isTablet, {bool isPhone = false, TextEditingController? controller}) {
    return Container(
      width: 331,
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 21,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: isMobile ? 54 : (isTablet ? 64 : 74),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFFFF69B4),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFFF69B4),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
