import 'package:elec_e_comm/view/home.dart';
import 'package:elec_e_comm/view/signup.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No user found for that email.",
              style: TextStyle(fontSize: 20),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "password provided is wrong",
              style: TextStyle(fontSize: 20),
            )));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(email);
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 233, 233, 1),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Image.asset("images/login.png"),
              Text(
                "Sign In",
                style: AppWidget.SemiBoldTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Enter the details below to\n                   Continue",
                style: AppWidget.lightTextStyle(),
              ),
              SizedBox(height: 15),
              Form(
                key: _formkey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: AppWidget.SemiBoldTextStyle(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            } else {
                              return null;
                            }
                          },
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Email"),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Password",
                        style: AppWidget.SemiBoldTextStyle(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the password";
                              } else {
                                return null;
                              }
                            },
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Password"),
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget Password?",
                    style: AppWidget.logingreen(),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email = emailcontroller.text;
                      password = passwordcontroller.text;
                    });
                  }
                  login();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppWidget.lightTextStyle(),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        )),
                    child: Text(
                      "Sign Up",
                      style: AppWidget.logingreen(),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
