import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagment/nextscreen/navigetor.dart';
// import 'package:librarymanagment/page/Signup.dart';
import 'package:librarymanagment/page/homepage.dart';
import 'package:librarymanagment/page/signup.dart';
import 'package:librarymanagment/screen/uiscreen.dart';
//import 'package:librarymanagment/signup/signup.dart';
import 'package:librarymanagment/validation/validation.dart';
import 'package:librarymanagment/widget/customsnackbar.dart';

class LogginScreen extends StatefulWidget {
  const LogginScreen({super.key});

  @override
  State<LogginScreen> createState() => _LogginScreenState();
}

class _LogginScreenState extends State<LogginScreen> {
  RegExp regExp = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$");
  final auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String emailError = "";
  String passwordError = "";
  String loginSignUpError = "";
  final key = GlobalKey<FormState>();
  final emailControlar = TextEditingController();
  final passwordcontrolar = TextEditingController();
  bool busy = false;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Logg-in Screen',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        backgroundColor: const Color(0xFFE0B485),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/image/splashbg.png"),
                      fit: BoxFit.cover)),
              child: Stack(children: [
                ListView(
                  children: [
                    const SizedBox(
                      height: 180,
                    ),
                    Container(
                        height: 220,
                        width: 200,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(UIConstrant.splashScreenLogo)))),
                    const SizedBox(
                      height: 40,
                    ),
                    (loginSignUpError == "")
                        ? const SizedBox(height: 0)
                        : Center(child: Text(loginSignUpError)),
                    Form(
                      key: key,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: emailControlar,
                              onSaved: (value) {
                                email = value!;
                              },
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return "Email Required";
                                }
                                return null;
                              }),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    emailError = "Enter your  Email";
                                  });
                                } else if (!regExp.hasMatch(value)) {
                                  setState(() {
                                    emailError = "Invalid Email";
                                  });
                                } else {
                                  setState(() {
                                    emailError = "";
                                    email = value;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter Your Email",
                                  errorText:
                                      emailError != "" ? emailError : null,
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Color(0xFF584846),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.brown))),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: passwordcontrolar,
                              onSaved: (value) {
                                password = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password Required";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.length < 6) {
                                  setState(() {
                                    passwordError = "Too Short";
                                  });
                                } else {
                                  setState(() {
                                    passwordError = "";
                                    password = value;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF584846),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF584846)),
                                ),
                                hintText: 'Enter Password',
                                errorText:
                                    passwordError == "" ? null : passwordError,
                              ),
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    if (validationAndSave(key)) {
                                      emailandpasswordSave();
                                      // CustomSnacbar(isWrning: false)
                                      //     .snackbarMassege(
                                      //         context, "SucessFully Logg in");
                                      // gotoNextScreen(context, HomePage());
                                    }
                                  },
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  color: const Color(0xFF584846),
                                  child: const Text("Sign In"),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Have any Account?"),
                              InkWell(
                                onTap: () {
                                  gotoNextScreen(context, const SiginUp());
                                },
                                child: const Text("Please Sign Up"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  emailandpasswordSave() async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: emailControlar.text, password: passwordcontrolar.text);

      // ignore: use_build_context_synchronously
      await CustomSnacbar(isWrning: false)
          .snackbarMassege(context, "Sucessfully Logg in");
      // ignore: use_build_context_synchronously
      gotoNextScreen(context, HomePage());
      setState(() {
        emailControlar.text = "";
        passwordcontrolar.text = "";
      });
      // ignore: use_build_context_synchronously

    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        CustomSnacbar(isWrning: true)
            .snackbarMassege(context, "user not Found");
        setState(() {});
      } else if (e.code == "Wrong-password") {
        CustomSnacbar(isWrning: true)
            .snackbarMassege(context, "Wrong password");
        setState(() {});
      }
    }
  }
}
