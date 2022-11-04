import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagment/main.dart';
import 'package:librarymanagment/nextscreen/navigetor.dart';
import 'package:librarymanagment/page/homepage.dart';
import 'package:librarymanagment/page/logginscreen.dart';
import 'package:librarymanagment/validation/validation.dart';
import 'package:librarymanagment/widget/customsnackbar.dart';

class SiginUp extends StatefulWidget {
  const SiginUp({super.key});

  @override
  State<SiginUp> createState() => _SiginUpState();
}

class _SiginUpState extends State<SiginUp> {
  String username = "";
  String email = "";
  String password = "";
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final nameControlar = TextEditingController();
  final emailControlar = TextEditingController();
  final passwordcontrolar = TextEditingController();
  final confirmPassword = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  var isPasswordVisibled = false;
  visiblepassword() {
    setState(() {
      isPasswordVisibled = true;
      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          isPasswordVisibled = false;
        });
      });
    });
  }

  confirmpasswordvisible() {
    setState(() {
      isPasswordVisibled = true;
      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          isPasswordVisibled = false;
        });
      });
    });
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/image/splashbg.png"),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                          height: 220,
                          width: 200,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("asset/image/logo_3.png")))),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                                controller: nameControlar,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required Name ";
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  username = value!;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter Your Name Here",
                                  hintStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF584846)),
                                  ),
                                )),
                            TextFormField(
                              controller: emailControlar,
                              decoration: const InputDecoration(
                                hintText: "Enter Your Email Here",
                                hintStyle: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.amber,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF584846)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Email";
                                } else if (!emailRegExp.hasMatch(value)) {
                                  return "Invalid  Email";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                email = value!;
                              },
                            ),
                            TextFormField(
                                controller: passwordcontrolar,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required Password";
                                  } else if (value.length < 6) {
                                    return "Password is too Short";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: !isPasswordVisibled,
                                onSaved: (value) {
                                  password = value!;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: "Enter Your Password here",
                                  hintStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: isPasswordVisibled
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.amber,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.amber,
                                            ),
                                      onPressed: () {
                                        visiblepassword();
                                      }),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF584846)),
                                  ),
                                )),
                            TextFormField(
                                controller: confirmPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required Password";
                                  } else if (value.length < 6) {
                                    return "Password is too Short";
                                  } else if (value != passwordcontrolar.text) {
                                    return "Password Mismatch";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: !isPasswordVisibled,
                                onSaved: (value) {
                                  password = value!;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: isPasswordVisibled
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.amber,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.amber,
                                            ),
                                      onPressed: () {
                                        confirmpasswordvisible();
                                      }),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF584846)),
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
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
                                      if (validationAndSave(_formkey)) {
                                        emailWithPassswordSave();
                                      }
                                      //gotoNextScreen(context, const SiginUp());
                                      // CustomSnacbar(isWrning: true)
                                      //     .snackbarMassege(
                                      //         context, "Logg in Fail");
                                      // setState(() {});
                                      //gotoNextScreen(context, const SiginUp());
                                    },
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    color: const Color(0xFF584846),
                                    child: const Text("Sign Up"),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Account here?"),
                                InkWell(
                                  onTap: () {
                                    gotoNextScreen(
                                        context, const LogginScreen());
                                  },
                                  child: const Text("Go To Sign In"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//

  emailWithPassswordSave() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailControlar.text,
        password: passwordcontrolar.text,
      );
      //ignore: use_build_context_synchronously
      CustomSnacbar(isWrning: false)
          .snackbarMassege(context, "SucessFully Signin in");
      // ignore: use_build_context_synchronously
      gotoNextScreen(context, HomePage());

      setState(() {
        nameControlar.text = "";
        emailControlar.text = "";
        passwordcontrolar.text = "";
        confirmPassword.text = "";
      });
      // ignore: use_build_context_synchronously

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomSnacbar(isWrning: true).snackbarMassege(context, "Weak Password");
        setState(() {});
        // ignore: use_build_context_synchronously
        //gotoNextScreen(context, HomePage());
      } else if (e.code == 'email-already-in-use') {
        CustomSnacbar(isWrning: true).snackbarMassege(
            context, 'The account already exists for that email');
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }
}
