import 'package:flutter/material.dart';

class AddClosePeoplePage extends StatelessWidget {
  const AddClosePeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive breakpoints
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
                  _buildInputField('Enter Name:', isMobile, isTablet),

                  // Phone Number Input Section
                  _buildInputField('Enter Phone Number:', isMobile, isTablet, isPhone: true),

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
                        onTap: () {
                          // Add button functionality here
                        },
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

  Widget _buildInputField(String label, bool isMobile, bool isTablet, {bool isPhone = false}) {
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
