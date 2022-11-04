import 'package:barcode/barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagment/model/book_model.dart';
import 'package:librarymanagment/page/textforminput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddnewBook extends StatefulWidget {
  final String isbn;
  const AddnewBook({super.key, required this.isbn});

  @override
  State<AddnewBook> createState() => _AddnewBookState();
}

class _AddnewBookState extends State<AddnewBook> {
  final _fromkey = GlobalKey<FormState>();
  List<Books> books = [];
  late Books book;
  DatabaseReference? reference;

  // final isbnControlar = TextEditingController();
  // final titleControlar = TextEditingController();
  // final authorControlar = TextEditingController();
  // final publisherControlar = TextEditingController();
  // final generationControlar = TextEditingController();

  //  Barcode bc = Barcode.code128();
  // String code
  Barcode bc = Barcode.code128();
  late String code;

  @override
  void initState() {
    book = Books();
    book.isbn = widget.isbn;
    book.status = "IN";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      //resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(right: 190),
              child: const Text("ADD A NEW BOOK ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF584846),
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  )),
            ),
            const SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Image.asset(
                    "asset/image/books123.png",
                    width: 200,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Flexible(
                    flex: 0,
                    child: Center(
                      child: Form(
                          key: _fromkey,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              // TextInputForm(
                              //     hintext: "Enter BookId",
                              //     intialvalue: "",
                              //     keabordtype: TextInputType.text,
                              //     onsave: (val) {
                              //       book.uId = val;
                              //     },
                              //     validator: ((val) => val == "" ? val : null)),
                              TextInputForm(
                                  //controller: isbnControlar,
                                  hintext: "Enter IsBN",
                                  intialvalue: "IsBN",
                                  keabordtype: TextInputType.text,
                                  onsave: (val) {
                                    book.isbn = val;
                                  },
                                  validator: ((val) => val == "" ? val : null)),
                              TextInputForm(
                                  //controller: titleControlar,
                                  hintext: "Enter title of the book",
                                  intialvalue: "Title",
                                  keabordtype: TextInputType.text,
                                  onsave: (val) {
                                    book.name = val;
                                  },
                                  validator: ((val) => val == "" ? val : null)),
                              TextInputForm(
                                  //controller: authorControlar,
                                  hintext: "Enter Author Name",
                                  intialvalue: "Author",
                                  keabordtype: TextInputType.text,
                                  onsave: (val) {
                                    book.author = val;
                                  },
                                  validator: ((val) => val == "" ? val : null)),
                              TextInputForm(
                                  //controller: publisherControlar,
                                  hintext: "Enter Publisher Name",
                                  intialvalue: "",
                                  keabordtype: TextInputType.text,
                                  onsave: (val) {
                                    book.publisher = val;
                                  },
                                  validator: ((val) => val == "" ? val : null)),
                              TextInputForm(
                                  //controller: generationControlar,
                                  hintext: "Enter Genre",
                                  intialvalue: "",
                                  keabordtype: TextInputType.text,
                                  onsave: (val) {
                                    book.genre = val;
                                  },
                                  validator: ((val) => val == "" ? val : null)),
                              SizedBox(
                                width: 350,
                                child: MaterialButton(
                                  color: const Color(0xFF584546),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0)),
                                  onPressed: (() async {
                                    _handleSubmit();
                                  }),
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(
                                        color: Color(0xFFF3BB84), fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void _handleSubmit() {
    final FormState? formState = _fromkey.currentState;
    final fireinstence = FirebaseFirestore.instance;
    if (formState != null) {
      if (formState.validate()) {
        formState.save();

        formState.reset();

        fireinstence.collection("books").add(book.tojson()).then((value) {
          print(value.id);
          setState(() {
            code = bc.toSvg(value.id);
            // isbnControlar.text = "";
            // titleControlar.text = "";
            // authorControlar.text = "";
            // publisherControlar.text = "";
            // generationControlar.text = "";
          });
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              title: const Text("Book Added"),
              children: [
                SizedBox(
                  height: 100,
                  width: 200,
                  child: SvgPicture.string(
                    code,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 25,
                )
              ],
            ),
          );
        });
      }
    }
  }
}
