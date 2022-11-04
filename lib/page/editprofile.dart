import 'package:flutter/material.dart';
import 'package:librarymanagment/page/profilepage.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
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
                height: 500,
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
                            backgroundImage:
                                AssetImage("asset/image/atiqur.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 52, top: 40, bottom: 30, right: 30),
                      height: 150,
                      width: 150,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 225,
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 335,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Full Name:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Text(
                            "Atiqur Rahman",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Montserrat"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 390,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Opacity(
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
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 10,
                          ),
                        ],
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
                      color: Color(0xFF584846),
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
                    trailing: Icon(
                      Icons.edit,
                      color: Color(0xFF584846),
                      size: 22,
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
                    trailing: Icon(
                      Icons.edit,
                      color: Color(0xFF584846),
                      size: 22,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: const Color(0xFF584846),
                          child: const Text("Previous",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: const Color(0xFF584846),
                          child: const Text("Save",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
