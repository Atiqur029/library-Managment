import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagment/nextscreen/navigetor.dart';
import 'package:librarymanagment/page/homepage.dart';
import 'package:librarymanagment/page/textforminput.dart';
import '../model/book_model.dart';

class ReturnBookPage extends StatefulWidget {
  const ReturnBookPage({super.key});

  @override
  State<ReturnBookPage> createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {
  final u_idcontrolar = TextEditingController();
  void onScan(BuildContext context) async {
    print(reresult);
    final firebaseInstence = FirebaseFirestore.instance;
    final temp =
        await firebaseInstence.collection("books").doc(reresult.trim()).get();
    if (!temp.exists) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Book doesn't eist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else if (temp.data()!["status"] != "OUT") {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Book isn't issued so can't returned",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      final tempQuery = FirebaseFirestore.instance
          .collection("log")
          .where("bookuId", isEqualTo: reresult.trim())
          .orderBy("date", descending: true)
          .limit(1)
          .get();

      firebaseInstence
          .collection("log")
          .doc(tempQuery.toString())
          .update({"returned": DateTime.now()});
      firebaseInstence
          .collection('books')
          .doc(reresult.trim())
          .update({"status": "IN"}).then((value) => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Book Returned",
                        style: TextStyle(color: Colors.greenAccent[500]),
                        textAlign: TextAlign.center),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5),
                        Image.asset("asset/image/done.png",
                            width: 200, height: 100)
                      ],
                    ),
                    actions: [
                      MaterialButton(
                        onPressed: (() {
                          gotoNextScreen(context, HomePage());
                        }),
                        color: Colors.green,
                        child: const Text("Ok"),
                      )
                    ],
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  child: Text("RETURN A BOOK",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF584846),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Column(children: [
                    Image.asset(
                      "asset/image/gruop_2.png",
                      width: 200,
                      height: 100,
                    )
                  ]),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Flexible(
              flex: 0,
              child: Center(
                child: Form(
                    child: Flex(
                  direction: Axis.vertical,
                  children: [
                    TextInputForm(
                      hintext: "U-Id",
                      intialvalue: reresult,
                      keabordtype: TextInputType.text,
                    )
                  ],
                )),
              )),
          SizedBox(
            width: 245,
            child: MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                onScan(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Text(
                "RETURN",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      )),
    );
  }
}
