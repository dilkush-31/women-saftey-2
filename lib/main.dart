import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'addclose_people.dart';
import 'fakecallsscreen.dart';
import 'firebase_options.dart';
import 'sos_service.dart';
import 'loginP_page.dart';
import 'signup_page.dart';
import 'sos_alert.dart';
import 'feature_cards.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EmpowerMeApp());
}

class SafetyApp extends StatelessWidget {
  const SafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF69B4),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF69B4)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(snapshot.data != null) {
              return  FoolOm();
            }

            return const SignUpPage();
          }),
    );
  }
}

class FoolOm extends StatelessWidget {
  FoolOm({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                _buildMainContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.28,
          width: double.infinity,
          color: const Color(0xFFFF69B4),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo1.png.jpg',
                            width: 65,
                            height: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Hey there! 👋',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user != null ? user!.email ?? 'No Email' : 'Guest',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _sendSOSAlert(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String locationUrl = "https://www.google.com/maps/search/?api=1&query=\${position.latitude},\${position.longitude}";
    await SOSActivatedScreen(context, locationUrl, locationUrl: '',);
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FeatureCard(
                  title: 'SOS Button',
                  imagePath: 'assets/sos.png.jpg',
                  icon: Icons.warning,
                  onTap: () async {
                    await _sendSOSAlert(context);
                  },  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FeatureCard(
                  title: 'Fake Calls',
                  imagePath: 'assets/fakecal.png.jpg',
                  icon: Icons.phone,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FakeCallsScreen()),
                    );
                  },  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LargeFeatureCard(
            title: 'Add Close People',
            subtitle: 'Add trusted contacts for SOS alerts',
            icon: Icons.group_add,
            buttonText: 'Add +',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddClosePeoplePage()),
              );
            }, imagepath: '',
          ),
          const SizedBox(height: 20),
          ImageFeatureCard(
            title: 'Start a Journey',
            subtitle: 'Track your journey with real-time updates',
            icon: Icons.map,
            imagePath: 'assets/logo3.jpg',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}



class ImageFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imagePath;
  final VoidCallback onTap;

  const ImageFeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imagePath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: 150),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(icon, size: 40, color: Colors.pink),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'addclose_people.dart';
// import 'fakecallsscreen.dart';
// import 'firebase_options.dart';
// import 'loginP_page.dart';
// import 'signup_page.dart';
// import 'first_page.dart';
// import 'sos_alert.dart';
// import 'feature_cards.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(const SafetyApp());
// }
//
// class SafetyApp extends StatelessWidget {
//   const SafetyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Women Safety App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFFFF69B4),
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF69B4)),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.data != null) {
//             return FoolOm();
//           }
//           return const SignUpPage();
//         },
//       ),
//     );
//   }
// }
//
// class FoolOm extends StatelessWidget {
//   FoolOm({super.key});
//   final user = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildHeader(context),
//               _buildMainContent(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top + 20, // Dynamic top padding
//         left: 20,
//         right: 20,
//         bottom: 20, // Prevents tight spacing
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF69B4),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 35, // Adjusted size to prevent overflow
//                 child: ClipOval(
//                   child: Image.asset(
//                     'assets/logo1.png.jpg',
//                     width: 65,
//                     height: 65,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hey there! 👋',
//                     style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
//                   ),
//                   Text(
//                     user != null ? user!.email ?? 'No Email' : 'Guest',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMainContent(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: FeatureCard(
//                   title: 'SOS Button',
//                   imagePath: 'assets/sos.png.jpg',
//                   icon: Icons.warning,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const SOSActivatedScreen()),
//                     );
//                   },
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: FeatureCard(
//                   title: 'Fake Calls',
//                   imagePath: 'assets/fakecal.png.jpg',
//                   icon: Icons.phone,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const FakeCallsScreen()),
//                     );
//                   },
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           LargeFeatureCard(
//             title: 'Add Close People',
//             subtitle: 'Add trusted contacts for SOS alerts',
//             icon: Icons.group_add,
//             buttonText: 'Add +',
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AddClosePeoplePage()),
//               );
//             },
//             imagepath: '',
//           ),
//           const SizedBox(height: 20),
//           ImageFeatureCard(
//             title: 'Start a Journey',
//             subtitle: 'Track your journey with real-time updates',
//             icon: Icons.map,
//             imagePath: 'assets/logo3.jpg',
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ImageFeatureCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final String imagePath;
//   final VoidCallback onTap;
//
//   const ImageFeatureCard({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.imagePath,
//     required this.onTap,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 150,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Row(
//                 children: [
//                   Icon(icon, size: 40, color: Colors.pink),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                       Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
