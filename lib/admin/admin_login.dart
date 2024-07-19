import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elec_e_comm/admin/home_admin.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _unamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snap) {
      snap.docs.forEach((result) {
        if (result.data()['username'] != _unamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your id is not correct",
            style: TextStyle(fontSize: 20),
          )));
        } else if (result.data()['password'] !=
            _passwordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your password is not correct",
            style: TextStyle(fontSize: 20),
          )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeAdmin(),
              ));
        }
      });
    });
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
            child: Column(
              children: [
                Image.asset("images/signup.png"),
                Text(
                  "Admin Panel",
                  style: AppWidget.SemiBoldTextStyle(),
                ),
                const SizedBox(height: 15),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
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
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Please Enter your Name";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          controller: _unamecontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Username"),
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
                            obscureText: true,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return "Please Enter your Password";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Password"),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    loginAdmin();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
