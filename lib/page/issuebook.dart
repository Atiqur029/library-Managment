import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagment/page/bookproblem.dart';
import 'package:librarymanagment/page/homepage.dart';

class ProblemBook extends StatefulWidget {
  const ProblemBook({super.key});

  @override
  State<ProblemBook> createState() => _ProblemBookState();
}

class _ProblemBookState extends State<ProblemBook> {
  Future<String> _barcodeScan() async {
    try {
      String qrResult = BarcodeScanner.scan().toString();
      return qrResult;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        throw Exception("Cemera permisson was Denied");
      } else {
        throw Exception("Unknown Error $e occurd");
      }
    } on FormatException {
      throw Exception("You pressed the back button before scanning anything");
    } catch (ex) {
      throw Exception("Unknown Error $ex occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _barcodeScan(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(
                  msg: snapshot.error.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return HomePage();
            }
            if (snapshot.hasData) {
              return IssueBook(
                barcode: snapshot.data!,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
