import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_first_project/signup_page.dart';
import 'dart:math';

import 'first_page.dart';

void main() {
  runApp(EmpowerMeApp());
}

class EmpowerMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.pink[50]!, Colors.white],
                ),
              ),
            ),
            // Main content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    // Logo and app name
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink[100]!.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CustomPaint(
                        size: const Size(80, 80),
                        painter: LogoPainter(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "EmpowerMe",
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[400],
                      ),
                    ),
                    Text(
                      "Your safety, Our Priority",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[700],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Text(
                        "Your personal safety companion. Stay connected, protected, and empowered with real-time protection features and emergency assistance.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink[400],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.pink[400]!, width: 2),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "© 2024 EmpowerMe. All rights reserved.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Main shield paint with anti-aliasing
    final paint =
        Paint()
          ..color = const Color(0xFFFF69B4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..isAntiAlias = true;

    // Create outer glow effect
    final glowPaint =
        Paint()
          ..color = const Color(0xFFFF69B4).withOpacity(0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3.0);

    // Draw modern shield outline with smoother curves
    final shieldPath =
        Path()
          ..moveTo(size.width * 0.5, size.height * 0.12)
          ..lineTo(size.width * 0.82, size.height * 0.25)
          ..quadraticBezierTo(
            size.width * 0.82,
            size.height * 0.55,
            size.width * 0.5,
            size.height * 0.88,
          )
          ..quadraticBezierTo(
            size.width * 0.18,
            size.height * 0.55,
            size.width * 0.18,
            size.height * 0.25,
          )
          ..lineTo(size.width * 0.5, size.height * 0.12);

    // Draw the glow effect
    canvas.drawPath(shieldPath, glowPaint);

    // Create gradient fill for shield
    final gradientPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFF69B4).withOpacity(0.1),
              const Color(0xFFFF69B4).withOpacity(0.15),
              const Color(0xFFFF69B4).withOpacity(0.2),
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Fill shield with gradient
    canvas.drawPath(shieldPath, gradientPaint);

    // Draw shield outline
    canvas.drawPath(shieldPath, paint);

    // Add decorative inner lines
    final innerPath1 =
        Path()
          ..moveTo(size.width * 0.3, size.height * 0.28)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.35,
            size.width * 0.7,
            size.height * 0.28,
          );
    canvas.drawPath(innerPath1, paint..strokeWidth = 1.5);

    final innerPath2 =
        Path()
          ..moveTo(size.width * 0.35, size.height * 0.72)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.78,
            size.width * 0.65,
            size.height * 0.72,
          );
    canvas.drawPath(innerPath2, paint..strokeWidth = 1.5);

    // Draw modernized Venus symbol
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.48;
    final radius = size.width * 0.14;

    // Draw circle with gradient
    final circlePaint =
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFFFF69B4).withOpacity(0.2),
              const Color(0xFFFF69B4).withOpacity(0.1),
            ],
          ).createShader(
            Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          )
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), radius, circlePaint);

    // Draw circle outline
    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
      paint..strokeWidth = 2.0,
    );

    // Draw stylized cross
    paint.strokeWidth = 2.0;
    // Vertical line
    canvas.drawLine(
      Offset(centerX, centerY + radius),
      Offset(centerX, centerY + radius * 1.4),
      paint,
    );
    // Horizontal line with curved ends
    final crossPath =
        Path()
          ..moveTo(centerX - radius * 0.5, centerY + radius * 1.2)
          ..quadraticBezierTo(
            centerX,
            centerY + radius * 1.2,
            centerX + radius * 0.5,
            centerY + radius * 1.2,
          );
    canvas.drawPath(crossPath, paint);

    // Add protective hands with smoother curves
    final leftHandPath =
        Path()
          ..moveTo(size.width * 0.32, size.height * 0.5)
          ..quadraticBezierTo(
            size.width * 0.25,
            size.height * 0.45,
            size.width * 0.22,
            size.height * 0.35,
          )
          ..quadraticBezierTo(
            size.width * 0.2,
            size.height * 0.32,
            size.width * 0.25,
            size.height * 0.32,
          );
    canvas.drawPath(leftHandPath, paint);

    final rightHandPath =
        Path()
          ..moveTo(size.width * 0.68, size.height * 0.5)
          ..quadraticBezierTo(
            size.width * 0.75,
            size.height * 0.45,
            size.width * 0.78,
            size.height * 0.35,
          )
          ..quadraticBezierTo(
            size.width * 0.8,
            size.height * 0.32,
            size.width * 0.75,
            size.height * 0.32,
          );
    canvas.drawPath(rightHandPath, paint);

    // Add subtle highlight effect
    final highlightPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    final highlightPath =
        Path()
          ..moveTo(size.width * 0.3, size.height * 0.2)
          ..quadraticBezierTo(
            size.width * 0.4,
            size.height * 0.25,
            size.width * 0.5,
            size.height * 0.2,
          );
    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
