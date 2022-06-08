import 'package:animate_do/animate_do.dart';
import 'package:firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first1(),
    builder: EasyLoading.init(),
  ));
}

class first1 extends StatefulWidget {
  const first1({Key? key}) : super(key: key);

  @override
  State<first1> createState() => _first1State();
}

class _first1State extends State<first1> {
  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          height: bodyheight,
          width: twidth,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: bodyheight * 0.40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(bodyheight * 0.25),
                    ),
                    gradient: LinearGradient(
                        stops: [
                          0.0,
                          0.4
                        ],
                        colors: [
                          Color(0xFFD64CA2).withOpacity(0.10),
                          Color(0xFFD64CA2).withOpacity(0.60)
                        ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomRight),
                  ),
                ),
              ),
              Positioned(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: bodyheight * 0.02,
                  ),
                  FadeInDown(
                    duration: Duration(seconds: 5),
                    child: Image(
                      image: AssetImage("images/check.png"),
                      width: twidth * 0.30,
                    ),
                  ),
                  SizedBox(
                    height: bodyheight * 0.02,
                  ),
                  Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: bodyheight * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: bodyheight * 0.18,
                  ),
                  Card(
                    child: Container(
                      height: bodyheight * 0.18,
                      width: double.infinity,
                      child: Column(
                        children: [
                          TextField(
                            controller: mail,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Email...",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xe1000211), width: 2)),
                            ),
                          ),
                          SizedBox(
                            height: bodyheight * 0.01,
                          ),
                          TextField(
                            controller: pass,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xe1000211), width: 2),
                              ),
                              labelText: "Enter Password...",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: bodyheight * 0.02,
                  ),
                  Container(
                    height: bodyheight * 0.35,
                    width: double.infinity,
                    child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FadeInDown(
                              duration: Duration(seconds: 5),
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                      email: mail.text,
                                      password: pass.text,
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                      Fluttertoast.showToast(
                                          msg:
                                              "The password provided is too weak",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                      Fluttertoast.showToast(
                                          msg:
                                              "The account already exists for that email.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }

                                  Fluttertoast.showToast(
                                      msg: "Registration Sucessfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: bodyheight * 0.03,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFD64CA2).withOpacity(0.60))),
                              ),
                            ),
                            FadeInDown(
                              duration: Duration(seconds: 5),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return login();
                                    },
                                  ));
                                },
                                child: Text(
                                  "SignIn",
                                  style: TextStyle(
                                      fontSize: bodyheight * 0.03,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFD64CA2).withOpacity(0.60))),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "______________________OR______________________",
                          style: TextStyle(color: Colors.grey),
                        ),
                        FadeInDown(
                          duration: Duration(seconds: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) {
                                  return first2();
                                },
                              ));
                            },
                            child: Text(
                              "LogIn With Mobile",
                              style: TextStyle(
                                  fontSize: bodyheight * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          "______________________OR______________________",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              "          Signup With ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: bodyheight * 0.03,
                              ),
                            ),
                            FadeInDown(duration: Duration(seconds: 5),
                              child: InkWell(
                                onTap: () {
                                  signInWithGoogle().then((value) {
                                    setState(() {
                                      print("=====${value}");
                                    });
                                  });
                                },
                                child: Container(
                                  height: bodyheight * 0.10,
                                  width: twidth * 0.32,
                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("images/google.gif"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              )),
            ],
          ),
        )),
      ),
    );
  }

  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class first2 extends StatefulWidget {
  const first2({Key? key}) : super(key: key);

  @override
  State<first2> createState() => _first2State();
}

class _first2State extends State<first2> {
  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;

    return WillPopScope(
      onWillPop: onback,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            height: bodyheight,
            width: twidth,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: bodyheight * 0.40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(bodyheight * 0.25),
                      ),
                      gradient: LinearGradient(
                          stops: [
                            0.0,
                            0.4
                          ],
                          colors: [
                            Color(0xFFD64CA2).withOpacity(0.10),
                            Color(0xFFD64CA2).withOpacity(0.60)
                          ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomRight),
                    ),
                  ),
                ),
                Positioned(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: bodyheight * 0.02,
                    ),
                    Image(
                      image: AssetImage("images/check.png"),
                      width: twidth * 0.30,
                    ),
                    SizedBox(
                      height: bodyheight * 0.02,
                    ),
                    Text(
                      "LogIn",
                      style: TextStyle(
                        fontSize: bodyheight * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: bodyheight * 0.18,
                    ),
                    Card(
                      child: Container(
                        height: bodyheight * 0.18,
                        child: Column(
                          children: [
                            TextField(
                              controller: mobileNo,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter Mobile Number...",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xe1000211), width: 2)),
                              ),
                            ),
                            SizedBox(
                              height: bodyheight * 0.01,
                            ),
                            TextField(
                              controller: otp,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xe1000211), width: 2),
                                ),
                                labelText: "Enter OTP...",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bodyheight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (mobileNo.text.length < 10) {
                              Fluttertoast.showToast(
                                  msg: "Check Mobile Number",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91 ${mobileNo.text}',
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  setState(() {
                                    verifyid = verificationId;
                                  });

                                  setState(() {
                                    Fluttertoast.showToast(
                                        msg: "OTP Send Sucessfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            }
                          },
                          child: Text(
                            "Mobile",
                            style: TextStyle(
                                fontSize: bodyheight * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0xFFD64CA2).withOpacity(0.60))),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            FirebaseAuth auth = FirebaseAuth.instance;

                            String smsCode = '${otp.text}';

                            // Create a PhoneAuthCredential with the code
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verifyid, smsCode: smsCode);

                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);

                            Fluttertoast.showToast(
                                msg: "Registration Sucessfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Future.delayed(Duration(seconds: 5)).then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return login();
                                },
                              ));
                            });
                          },
                          child: Text(
                            "OTP",
                            style: TextStyle(
                                fontSize: bodyheight * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0xFFD64CA2).withOpacity(0.60))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: bodyheight * 0.05,
                    ),
                    Text(
                      "______________________OR______________________",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Text(
                          "          Signup With ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: bodyheight * 0.03,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            signInWithGoogle().then((value) {
                              setState(() {
                                print("=====${value}");
                              });
                            });
                          },
                          child: Container(
                            height: bodyheight * 0.10,
                            width: twidth * 0.32,
                            margin: EdgeInsets.all(bodyheight * 0.01),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/google.gif"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        )),
      ),
    );
  }

  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  String verifyid = "";

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> onback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return first1();
      },
    ));

    return Future.value(true);
  }
}

// class fire extends StatefulWidget {
//   const fire({Key? key}) : super(key: key);
//
//   @override
//   State<fire> createState() => _fireState();
// }
//
// class _fireState extends State<fire> {
//   @override
//   Widget build(BuildContext context) {
//     double theight = MediaQuery.of(context).size.height;
//     double twidth = MediaQuery.of(context).size.width;
//     double statusbarheight = MediaQuery.of(context).padding.top;
//     double tnaviheight = MediaQuery.of(context).padding.bottom;
//     double tappbar = kToolbarHeight;
//
//     double bodyheight = theight - tappbar - statusbarheight - tnaviheight;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase"),
//         backgroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Column(
//           children: [
//             SizedBox(
//               height: bodyheight * 0.05,
//             ),
//             TextField(
//               controller: mail,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(), labelText: "Email"),
//             ),
//             TextField(
//               controller: pass,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(), labelText: "Password"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (mobileNo.text.length < 10) {
//                   Fluttertoast.showToast(
//                       msg: "Check Mobile Number",
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.CENTER,
//                       timeInSecForIosWeb: 1,
//                       backgroundColor: Colors.red,
//                       textColor: Colors.white,
//                       fontSize: 16.0);
//                 } else {
//                   await FirebaseAuth.instance.verifyPhoneNumber(
//                     phoneNumber: '+91 ${mobileNo.text}',
//                     verificationCompleted: (PhoneAuthCredential credential) {},
//                     verificationFailed: (FirebaseAuthException e) {},
//                     codeSent: (String verificationId, int? resendToken) {
//                       setState(() {
//                         verifyid = verificationId;
//                       });
//
//                       setState(() {
//                         Fluttertoast.showToast(
//                             msg: "OTP Send Sucessfully",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.CENTER,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: Colors.red,
//                             textColor: Colors.white,
//                             fontSize: 16.0);
//                       });
//                     },
//                     codeAutoRetrievalTimeout: (String verificationId) {},
//                   );
//                 }
//               },
//               child: Text(
//                 "Mobile",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black)),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 FirebaseAuth auth = FirebaseAuth.instance;
//
//                 String smsCode = '${otp.text}';
//
//                 // Create a PhoneAuthCredential with the code
//                 PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                     verificationId: verifyid, smsCode: smsCode);
//
//                 // Sign the user in (or link) with the credential
//                 await auth.signInWithCredential(credential);
//               },
//               child: Text(
//                 "OTP",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black)),
//             ),
//
//             // only Click on Button
//             ElevatedButton(
//               onPressed: () {
//                 signInWithGoogle().then((value) {
//                   setState(() {
//                     print("=====${value}");
//                   });
//                 });
//               },
//               child: Text(
//                 "Sign In with Google",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black)),
//             ),
//
//             SizedBox(
//               height: bodyheight * 0.02,
//             ),
//             TextField(
//               controller: mobileNo,
//               keyboardType: TextInputType.number,
//               maxLength: 10,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(), labelText: "Enter Mobile No"),
//             ),
//             TextField(
//               controller: otp,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(), labelText: "Enter OTP"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (mobileNo.text.length < 10) {
//                   Fluttertoast.showToast(
//                       msg: "Check Mobile Number",
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.CENTER,
//                       timeInSecForIosWeb: 1,
//                       backgroundColor: Colors.red,
//                       textColor: Colors.white,
//                       fontSize: 16.0);
//                 } else {
//                   await FirebaseAuth.instance.verifyPhoneNumber(
//                     phoneNumber: '+91 ${mobileNo.text}',
//                     verificationCompleted: (PhoneAuthCredential credential) {},
//                     verificationFailed: (FirebaseAuthException e) {},
//                     codeSent: (String verificationId, int? resendToken) {
//                       setState(() {
//                         verifyid = verificationId;
//                       });
//
//                       setState(() {
//                         Fluttertoast.showToast(
//                             msg: "OTP Send Sucessfully",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.CENTER,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: Colors.red,
//                             textColor: Colors.white,
//                             fontSize: 16.0);
//                       });
//                     },
//                     codeAutoRetrievalTimeout: (String verificationId) {},
//                   );
//                 }
//               },
//               child: Text(
//                 "Mobile No",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black)),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 FirebaseAuth auth = FirebaseAuth.instance;
//
//                 String smsCode = '${otp.text}';
//
//                 // Create a PhoneAuthCredential with the code
//                 PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                     verificationId: verifyid, smsCode: smsCode);
//
//                 // Sign the user in (or link) with the credential
//                 await auth.signInWithCredential(credential);
//               },
//               child: Text(
//                 "Otp",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.black)),
//             ),
//             SizedBox(
//               height: bodyheight * 0.05,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: twidth * 0.20,
//                 ),
//                 Text(
//                   "Already Have Account",
//                   style: TextStyle(
//                       fontSize: bodyheight * 0.02, color: Colors.blue),
//                 ),
//                 InkWell(
//                     onTap: () {
//                       Navigator.pushReplacement(context, MaterialPageRoute(
//                         builder: (context) {
//                           return login();
//                         },
//                       ));
//                     },
//                     child: Text(
//                       "   LogIn",
//                       style: TextStyle(
//                           fontSize: bodyheight * 0.03, color: Colors.black),
//                     ))
//               ],
//             )
//           ],
//         )),
//       ),
//     );
//   }
//
//   TextEditingController mail = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController mobileNo = TextEditingController();
//   TextEditingController otp = TextEditingController();
//
//   String verifyid = "";
//
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
