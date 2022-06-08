import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: fire(),
  ));
}

class fire extends StatefulWidget {
  const fire({Key? key}) : super(key: key);

  @override
  State<fire> createState() => _fireState();
}

class _fireState extends State<fire> {
  @override
  Widget build(BuildContext context) {

    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double tnaviheight = MediaQuery.of(context).padding.bottom;
    double tappbar = kToolbarHeight;

    double bodyheight = theight - tappbar - statusbarheight - tnaviheight;

    return Scaffold(appBar: AppBar(title: Text("Firebase"),backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                SizedBox(height:bodyheight*0.05,),
                TextField(
                  controller: mail,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Email"),
                ),
                TextField(
                  controller: pass,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Password"),
                ),
                ElevatedButton(
                  onPressed: () async {

                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: mail.text,
                        password: pass.text,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        Fluttertoast.showToast(
                            msg: "The password provided is too weak",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        Fluttertoast.showToast(
                            msg: "The account already exists for that email.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                      }
                    } catch (e) {
                      print(e);
                    }


                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize:20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () async {

                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: mail.text,
                          password: pass.text
                      );
                      print("=====Yes");

                      Fluttertoast.showToast(
                          msg: "login Sucessflully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        // print('No user found for that email.');
                        print("=========Email Not Found");

                        Fluttertoast.showToast(
                            msg: "Email Not Found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }


                      else if (e.code == 'wrong-password') {
                        // print('Wrong password provided for that user.');
                        print("======Wrong password");
                        Fluttertoast.showToast(
                            msg: "Wrong password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );


                      }
                    }

                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize:20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),


                // only Click on Button
                ElevatedButton(
                  onPressed: () {

                    signInWithGoogle().then((value) {

                        setState(() {
                          print("=====${value}");
                        });
                      
                    });

                  },
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(fontSize:20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),


                SizedBox(height: bodyheight*0.02,),
                TextField(
                  controller: mobileNo,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Enter Mobile No"),
                ),
                TextField(
                  controller: otp,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Enter OTP"),
                ),
                ElevatedButton(
                  onPressed: () async {

                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91 ${mobileNo.text}',
                      verificationCompleted: (PhoneAuthCredential credential) {

                      },
                      verificationFailed: (FirebaseAuthException e) {

                      },
                      codeSent: (String verificationId, int? resendToken) {
                             setState(() {
                               verifyid=verificationId;
                             });

                             setState(() {
                               Fluttertoast.showToast(
                                   msg: "OTP Send Sucessfully",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             });
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {

                      },
                    );
                  },
                  child: Text(
                    "Mobile No",
                    style: TextStyle(fontSize:20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;

                      String smsCode = '${otp.text}';

                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyid, smsCode: smsCode);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
    

                  },
                  child: Text(
                    "Otp",
                    style: TextStyle(fontSize:20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                ),
              ],
            )),
      ),
    );
  }

  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();

  String verifyid="";


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}



