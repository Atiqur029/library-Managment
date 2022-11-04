import 'package:flutter/material.dart';
import 'package:librarymanagment/nextscreen/navigetor.dart';
import 'package:librarymanagment/page/editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 450,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 499,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0B485),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(27.0),
                        bottomRight: Radius.circular(27.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xFFE0B485),
                      child: Opacity(
                        opacity: 0.8,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage("asset/image/atiqur.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 335,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Full Name :",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat"),
                        ),
                        Text(
                          "Atiqur Rahman",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Montserrat"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 390,
                    child: const Opacity(
                      opacity: 0.7,
                      child: Text(
                        'Admin',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Color((0xFF584846)),
                  ),
                  title: Text(
                    'Phone Number',
                    style: TextStyle(
                        color: Color(0xFF584846),
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '+ 880 1740070497',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Color(0xFF584846),
                  ),
                  title: Text(
                    'Email',
                    style: TextStyle(
                        color: Color(0xFF584846),
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'atiqur8061029@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          gotoNextScreen(context, const Editprofile());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        color: const Color(0xFF584846),
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
