import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagment/nextscreen/navigetor.dart';
import 'package:librarymanagment/page/homepage.dart';
import 'package:librarymanagment/page/logginscreen.dart';
import 'package:librarymanagment/screen/uiscreen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     startTime();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE0B485),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("asset/image/splashbg.png"),
//                 fit: BoxFit.cover)),
//         child: ListView(
//           children: [
//             const SizedBox(
//               height: 180,
//             ),
//             Container(
//               height: 220,
//               width: 220,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(UIConstrant.splashScreenLogo),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Text(
//                   'LIBRARY',
//                   style: TextStyle(
//                     color: Color(0xFFDD3617),
//                     fontSize: 28,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   'MANAGED',
//                   style: TextStyle(
//                     color: Color(0xFF584846),
//                     fontSize: 28,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   startTime() async {
//     var duration = const Duration(seconds: 3);
//     return Timer(duration, navigate);
//   }

//   void navigate() {
//     if (FirebaseAuth.instance.currentUser != null) {
//       gotoNextScreen(context, HomePage());
//     } else {
//       gotoNextScreen(context, const LogginScreen());
//     }
//   }
// }

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigate);
  }

  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      gotoNextScreen(context, HomePage());
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LogginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0B485),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'asset/image/splashbg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  Container(
                    height: 220,
                    width: 220,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(UIConstrant.splashScreenLogo),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'LIBRARY',
                        style: TextStyle(
                          color: Color(0xFFDD3617),
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'MANAGED',
                        style: TextStyle(
                          color: Color(0xFF584846),
                          fontSize: 28,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
