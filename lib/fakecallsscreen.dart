import 'package:flutter/material.dart';

import 'addclose_people.dart';

class FakeCallsScreen extends StatelessWidget {
  const FakeCallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEAF1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 20),
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF69B4),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                const SizedBox(height: 31),

                // Title
                const Text(
                  'Fake calls',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 31),

                // Description
                const Text(
                  'The Fake Call features help users escape uncomfortable or dangerous situations by triggering a simulated phone call.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.32,
                  ),
                ),

                const SizedBox(height: 27),

                // White Container
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 29,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Saved Contacts:',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.46,
                          ),
                        ),

                        const SizedBox(height: 42),

                        // Contact Buttons
                        for (var contact in ['Mom', 'Dad', 'Guardian'])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: 262,
                              height: 59,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF69B4),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  contact,
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.42,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        const SizedBox(height: 29),

                        // Add Button
                        GestureDetector(
                          onTap: () {
                            print("Add button tapped");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const AddClosePeoplePage()),
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF69B4),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFB7CE),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Call Now Button
                        Center(
                          child: Container(
                            width: 180,
                            height: 59,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF69B4),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'CALL NOW',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.42,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 132),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
