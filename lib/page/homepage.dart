import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagment/method/display.dart';
import 'package:librarymanagment/page/inventory.dart';
import 'package:librarymanagment/page/issuebook.dart';
import 'package:librarymanagment/page/profilepage.dart';
import 'package:librarymanagment/page/returnbookpage.dart';

import '../model/book_model.dart';
import '../nextscreen/navigetor.dart';
import 'addnewbookpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var result;
  // var reresult;
  Future _scanQr() async {
    try {
      String qrResult = BarcodeScanner.scan().toString();
      setState(() {
        result = qrResult;
      });

      // ignore: use_build_context_synchronously
      gotoNextScreen(context, AddnewBook(isbn: result));
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "";
        });
        Fluttertoast.showToast(
            msg: "Cemera permisson was denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        gotoNextScreen(context, AddnewBook(isbn: result));
      }
    } on FormatException {
      setState(() {
        result = "";
      });
      Fluttertoast.showToast(
          msg: "You pressed the back button before scanning anything",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (ex) {
      setState(() {
        result = "";
      });
      Fluttertoast.showToast(
          msg: "Unknown Error $ex",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddnewBook(
              isbn: result,
            ),
          ));
    }
  }

  _scanarQr() {
    try {
      String mainresult = BarcodeScanner.scan().toString();
      setState(() {
        reresult = mainresult;
      });
      gotoNextScreen(context, const ReturnBookPage());
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessGranted) {
        setState(() {});
      } else {
        setState(() {});
      }
    } catch (ex) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.apps,
                      color: Color(0xFF584846),
                      size: 40,
                    ),
                  )
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Color(0xFFDD3617),
                ),
                onPressed: () {
                  gotoNextScreen(context, const ProfilePage());
                },
              ),
            ],
          ),
        ),
        Row(
          children: const [
            Padding(padding: EdgeInsets.only(left: 20)),
            Text('Welcome!',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF584846),
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        display1(context, () {
          gotoNextScreen(context, const Inventory());
        }, "INVENTORY", const Color.fromRGBO(33, 150, 243, 1), Colors.white70,
            const Color(0xFF584846)),
        display1(context, () {
          _scanQr();
        }, "Add New Book", const Color.fromRGBO(33, 150, 243, 1),
            Colors.white70, const Color(0xFF584846)),
        display1(
          context,
          () {
            _scanarQr();
          },
          "RETURN BOOK",
          Colors.white38,
          Colors.white70,
          const Color(0xFF584846),
        ),
        display1(
          context,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProblemBook(),
              ),
            );
          },
          "ISSUE BOOK",
          Colors.white38,
          Colors.white70,
          const Color(0xFF584846),
        ),
      ]),
    );
  }
}
