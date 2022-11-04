// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagment/method/validationemil.dart';
import 'package:librarymanagment/method/validationmobile.dart';
import 'package:librarymanagment/nextscreen/navigetor.dart';
import 'package:librarymanagment/voice/invoice.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'package:librarymanagment/page/homepage.dart';

import '../method/initfile.dart';

class IssueBook extends StatefulWidget {
  final String barcode;
  const IssueBook({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  @override
  State<IssueBook> createState() => _IssueBookState();
}

class _IssueBookState extends State<IssueBook> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference log = FirebaseFirestore.instance.collection("log");
  CollectionReference book = FirebaseFirestore.instance.collection("books");
  late DateTime issuedate;
  late DateTime dueDate;
  late int invoiceno;
  late int currentindex;
  late String dir;
  late String path;
  // ignore: prefer_typing_uninitialized_variables
  var emailTransport;

  // ignore: deprecated_member_use
  final smtpServer = gmail(username, password);

  static String username = "";

  static String password = "";
  TextEditingController issuerEmail = TextEditingController();
  TextEditingController issuerPhone = TextEditingController();
  TextEditingController issuerName = TextEditingController();

  // static String get username => "sumon";

  // static String get password => "123";
  // final SmtpServer=gmail(username, password);
  // SmtpServer gmail(String username, String password) =>
  //     SmtpServer('smtp.gmail.com', username: username, password: password);

  @override
  void initState() {
    super.initState();
    init();
    currentindex = 0;
    emailTransport = smtpServer;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Issue Book Page",
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: FutureBuilder<DocumentSnapshot>(
            future: book.doc(widget.barcode).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return SizedBox(
                      child: Center(child: Text(snapshot.error.toString())));
                }
                if (snapshot.hasData) {
                  if (!snapshot.data!.exists) {
                    {
                      Fluttertoast.showToast(
                          msg: "Book Doesn't exist",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return HomePage();
                    }
                  } else {
                    return IndexedStack(
                      index: currentindex,
                      children: [
                        SizedBox(
                          child: Form(
                              key: _formKey,
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                children: [
                                  Column(
                                    children: [
                                      Image.asset("asset/image/books123.png"),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        color: Colors.grey[200],
                                        child: ListTile(
                                          title: TextFormField(
                                            decoration:
                                                const InputDecoration.collapsed(
                                              hintText: "",
                                            ),
                                            initialValue: widget.barcode,
                                            enabled: false,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: DateTimeFormField(
                                      onDateSelected: (value) {
                                        setState(() {
                                          issuedate = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.black45),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: OutlineInputBorder(),
                                          suffixIcon: Icon(Icons.event_note),
                                          labelText: 'Issue Date'),
                                      initialDate: DateTime.now(),
                                      onSaved: (value) {
                                        setState(() {
                                          issuedate = value!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return "Issue Date Required";
                                        }
                                        return null;
                                      },
                                      lastDate: DateTime(2100)
                                          .add(const Duration(days: 15)),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 3)),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: DateTimeFormField(
                                      initialValue: DateTime.now()
                                          .add(const Duration(days: 15)),
                                      validator: (value) {
                                        if (value == null) {
                                          return "Due Date Required";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.black45),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: OutlineInputBorder(),
                                          suffixIcon: Icon(Icons.event_note),
                                          labelText: 'Due Date'),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 45)),
                                      onSaved: (value) {
                                        setState(() {
                                          dueDate = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      validator: (value) {
                                        validateEmail(value!);
                                      },
                                      controller: issuerEmail,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Color(0xFF584846),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF584846)),
                                        ),
                                        hintText: '\tEnter Email-id',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      validator: (value) =>
                                          validateMobile(value!),
                                      controller: issuerPhone,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Color(0xFF584846),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF584846)),
                                        ),
                                        hintText: '\tEnter Phone Number',
                                      ),
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      // onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.length > 4) {
                                          return null;
                                        } else {
                                          return "Too Short";
                                        }
                                      },
                                      controller: issuerName,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Color(0xFF584846),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF584846)),
                                        ),
                                        hintText: '\tEnter Name',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0, vertical: 20),
                                    child: MaterialButton(
                                        color: Colors.blue,
                                        disabledColor: Colors.blue,
                                        onPressed: () async {
                                          _formKey.currentState!.save();
                                          _handleSubmit(
                                              snapshot as DocumentSnapshot);
                                        },
                                        child: const Text("Issue")),
                                  ),
                                ],
                              )),
                        ),
                        const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      ],
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              } else {
                return const Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(),
                ));
              }
            }),
          ),
        ),
      ),
    );
  }

  _handleSubmit(DocumentSnapshot snapshot) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        currentindex = 1;
      });
      final File file = File(path);
      await FirebaseFirestore.instance
          .collection("invoice")
          .doc("invoice")
          .get()
          .then((value) {
        setState(() {
          invoiceno = value.data()!["invoiceno"];
        });
      });
      Uint8List byte = await genareteInvoice(
          invoiceno.toString(),
          snapshot,
          issuerName.text,
          issuerPhone.text,
          issuerEmail.text,
          issuedate,
          dueDate);
      await file.writeAsBytes(byte);
      // Create our message.
      final message = Message()
        ..from = Address(username, 'Your name')
        ..recipients.add(issuerEmail.text)
        ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
        ..bccRecipients.add(const Address('bccAddress@example.com'))
        ..subject = 'Book Issued :: 😀 :: ${DateTime.now()}'
        ..text = 'This is the plain text.\nThis is line 2 of the text part.';

      // final messege = Envelope()
      //   ..from = username
      //   ..recipients.add(issuerEmail.text)
      //   ..subject = 'Book Issued 😀 '
      //   ..attachments.add(Attachment(file: file))
      //   ..text = 'Please see the below attached pdf for details ';
      await book.doc(widget.barcode).update({"STATUS": "OUT"});
      await FirebaseFirestore.instance
          .collection("invoice")
          .doc("invoice")
          .update({"invoiceno": FieldValue.increment(1)});
      log.doc().set({
        "date": issuedate,
        "issuerName": issuerName.text,
        "issuerEmail": issuerEmail.text,
        "issuerPhone": issuerPhone.text,
        "bookid": widget.barcode,
        "dueDate": dueDate
      }).whenComplete(() {
        setState(() {
          currentindex = 0;
        });
        gotoNextScreen(context, HomePage());
        // Navigator.popUntil(context, ModalRoute.withName(HomePage.id));
        Fluttertoast.showToast(msg: "Issued");
      });
      try {
        final sendReport = await send(message, smtpServer);
      } on MailerException catch (e) {
        Fluttertoast.showToast(msg: "Some thing Wrong $e");
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }

      // void _handleSubmit(DocumentSnapshot snap) async {
      //   if (_formKey.currentState!.validate()) {
      //     setState(() {
      //       currentindex = 1;
      //     });
      //     final File file = File(path);
      //     await FirebaseFirestore.instance
      //         .collection("invoice")
      //         .doc("invoice")
      //         .get()
      //         .then((value) {
      //       setState(() {
      //         invoiceno = value.data()!["invoiceno"];
      //       });
      //     });
      //     Uint8List byte = await genareteInvoice(
      //         invoiceno.toString(),
      //         snap,
      //         issuerName.text,
      //         issuerPhone.text,
      //         issuerEmail.text,
      //         issuedate,
      //         dueDate);
      //     await file.writeAsBytes(byte);
      //     final messege = Envelope()
      //       ..from = username
      //       ..recipients.add(issuerEmail.text)
      //       ..subject = 'Book Issued 😀 '
      //       ..attachments.add(Attachment(file: file))
      //       ..text = 'Please see the below attached pdf for details ';
      //     await book.doc(widget.barcode).update({"STATUS": "OUT"});
      //     await FirebaseFirestore.instance
      //         .collection("invoice")
      //         .doc("invoice")
      //         .update({"invoiceno": FieldValue.increment(1)});
      //     log.doc().set({
      //       "date": issuedate,
      //       "issuerName": issuerName.text,
      //       "issuerEmail": issuerEmail.text,
      //       "issuerPhone": issuerPhone.text,
      //       "bookid": widget.barcode,
      //       "dueDate": dueDate
      //     }).whenComplete(() {
      //       setState(() {
      //         currentindex = 0;
      //       });
      //       Navigator.popUntil(context, ModalRoute.withName(HomePage.id));
      //       Fluttertoast.showToast(msg: "Issued");
      //     });
      //     try {
      //       await emailTransport
      //           .send(messege)
      //           .whenComplete(() => Fluttertoast.showToast(msg: 'Email sent: '));
      //     } catch (e) {
      //       Fluttertoast.showToast(
      //           msg: "Book Issued but Email not sent due to: $e");
      //     }
      //   } else {
      //     Fluttertoast.showToast(
      //       gravity: ToastGravity.CENTER,
      //       msg: "Fill Form properly",
      //     );
      //   }
      // }
    }
  }
}
