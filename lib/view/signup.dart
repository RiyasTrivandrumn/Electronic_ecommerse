// import 'package:elec_e_comm/services/database.dart';
// import 'package:elec_e_comm/view/login.dart';
// import 'package:elec_e_comm/view/widgets/bottom_nav.dart';
// import 'package:elec_e_comm/view/widgets/support_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:random_string/random_string.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   String? name, email, password;
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   final _formkey = GlobalKey<FormState>();

//   void registration() async {
//     if (password != null && name != null && email != null) {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email!, password: password!);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: Colors.redAccent,
//           content: const Text(
//             "Registered Successfully",
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ));

//         String Id = randomAlphaNumeric(10);

//         Map<String, dynamic> userinfo = {
//           "name": namecontroller.text,
//           "email": emailcontroller.text,
//           "id": Id,
//           "Image":
//               "https://images.smiletemplates.com/uploads/screenshots/179/0000179308/powerpoint-template-450w.jpg"
//         };
//         await DatabaseMethods().addUserDetails(userinfo, Id);

//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const BottomNav(),
//             ));
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'week-password') {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               backgroundColor: Colors.redAccent,
//               content: const Text(
//                 "Password Provided is too week",
//                 style: TextStyle(fontSize: 20),
//               )));
//         } else if (e.code == "email-already-in-use") {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               backgroundColor: Colors.redAccent,
//               content: const Text(
//                 "Account already exist",
//                 style: TextStyle(fontSize: 20),
//               )));
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(221, 233, 233, 1),
//       body: SingleChildScrollView(
//         child: Container(
//           margin:
//               const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 20),
//           child: Form(
//             key: _formkey,
//             child: Column(
//               children: [
//                 Image.asset("images/signup.png"),
//                 Text(
//                   "Sign Up",
//                   style: AppWidget.SemiBoldTextStyle(),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Please Enter the details below to\n                   Continue",
//                   style: AppWidget.lightTextStyle(),
//                 ),
//                 const SizedBox(height: 15),
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Name",
//                         style: AppWidget.SemiBoldTextStyle(),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(left: 15),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white),
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Please Enter your Name";
//                             } else {
//                               return null;
//                             }
//                           },
//                           controller: namecontroller,
//                           decoration: InputDecoration(
//                               border: InputBorder.none, hintText: "Name"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Text(
//                         "Email",
//                         style: AppWidget.SemiBoldTextStyle(),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(left: 15),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white),
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Please Enter your Email";
//                             } else {
//                               return null;
//                             }
//                           },
//                           controller: emailcontroller,
//                           decoration: InputDecoration(
//                               border: InputBorder.none, hintText: "Email"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Text(
//                         "Password",
//                         style: AppWidget.SemiBoldTextStyle(),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                           padding: EdgeInsets.only(left: 15),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white),
//                           child: TextFormField(
//                             obscureText: true,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Please Enter your Password";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             controller: passwordcontroller,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none, hintText: "Password"),
//                           ))
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     if (_formkey.currentState!.validate()) {
//                       setState(() {
//                         name = namecontroller.text;
//                         email = emailcontroller.text;
//                         password = passwordcontroller.text;
//                       });
//                     }
//                     registration();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 14),
//                     width: MediaQuery.of(context).size.width / 2,
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Center(
//                         child: Text(
//                       "SIGN UP",
//                       style: TextStyle(color: Colors.white, fontSize: 22),
//                     )),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Already have an account? ",
//                       style: AppWidget.lightTextStyle(),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Login(),
//                             ));
//                       },
//                       child: Text(
//                         "Sign In",
//                         style: AppWidget.logingreen(),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/services/shared_prefs.dart';
import 'package:elec_e_comm/view/login.dart';
import 'package:elec_e_comm/view/widgets/bottom_nav.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, email, password;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void registration() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        name = namecontroller.text;
        email = emailcontroller.text;
        password = passwordcontroller.text;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: const Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ));

        String Id = randomAlphaNumeric(10);

        Map<String, dynamic> userinfo = {
          "name": namecontroller.text,
          "email": emailcontroller.text,
          "id": Id,
          "Image":
              "https://images.smiletemplates.com/uploads/screenshots/179/0000179308/powerpoint-template-450w.jpg"
        };
        await DatabaseMethods().addUserDetails(userinfo, Id);
        await SharedPreferencesHelper().saveUserName(namecontroller.text);
        await SharedPreferencesHelper().saveUserId(Id);
        await SharedPreferencesHelper().saveUserEmail(emailcontroller.text);
        await SharedPreferencesHelper().saveUserImage(
            "https://images.smiletemplates.com/uploads/screenshots/179/0000179308/powerpoint-template-450w.jpg");

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNav(),
            ));
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = "Password Provided is too weak";
        } else if (e.code == "email-already-in-use") {
          errorMessage = "Account already exists";
        } else {
          errorMessage = "An unknown error occurred";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              errorMessage,
              style: const TextStyle(fontSize: 20),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 233, 233, 1),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("images/signup.png"),
                Text(
                  "Sign Up",
                  style: AppWidget.SemiBoldTextStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Please Enter the details below to\n                   Continue",
                  style: AppWidget.lightTextStyle(),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: AppWidget.SemiBoldTextStyle(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Name";
                          } else {
                            return null;
                          }
                        },
                        controller: namecontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Name"),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email",
                      style: AppWidget.SemiBoldTextStyle(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Email";
                          } else {
                            return null;
                          }
                        },
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Email"),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Password",
                      style: AppWidget.SemiBoldTextStyle(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your Password";
                            } else {
                              return null;
                            }
                          },
                          controller: passwordcontroller,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Password"),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      registration();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppWidget.lightTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                      },
                      child: Text(
                        "Sign In",
                        style: AppWidget.logingreen(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
