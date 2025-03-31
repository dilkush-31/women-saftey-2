import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        elevation: 0,
        title: Text(
          'About EmpowerMe',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE91E63),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shield_outlined,
                      size: 48,
                      color: Colors.pink[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Version 1.0.0',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'About Us',
                    'EmpowerMe is a women\'s safety app designed to provide immediate assistance and support in emergency situations. Our mission is to create a safer environment for women through technology and community support.',
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Key Features',
                    '• SOS Alert: Quick emergency assistance with location sharing\n'
                        '• Fake Call: Generate convincing fake calls for uncomfortable situations\n'
                        '• Emergency Contacts: Add and manage trusted contacts\n'
                        '• Real-time Location Tracking: Share your journey with trusted contacts',
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Privacy & Security',
                    'We prioritize your privacy and security. All personal data is encrypted and stored securely. Your location information is only shared during emergencies with your chosen contacts.',
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Contact Us',
                    'Email: support@empowerme.com\n'
                        'Website: www.empowerme.com\n'
                        'Emergency Support: Available 24/7',
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      '© 2024 EmpowerMe\nAll rights reserved',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.pink[700],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
