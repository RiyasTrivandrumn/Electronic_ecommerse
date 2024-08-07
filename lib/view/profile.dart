import 'dart:io';

import 'package:elec_e_comm/services/auth.dart';
import 'package:elec_e_comm/services/shared_prefs.dart';
import 'package:elec_e_comm/view/bording.dart';
import 'package:elec_e_comm/view/login.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  File? selectedimage;
  String? image, name, email;

  getthesharedpref() async {
    image = await SharedPreferencesHelper().getUserImage();
    name = await SharedPreferencesHelper().getUserName();
    email = await SharedPreferencesHelper().getUserEmail();

    setState(() {});
  }

  Future getImage() async {
    if (await _requestPermission(Permission.photos)) {
      var image = await _picker.pickImage(source: ImageSource.gallery);
      selectedimage = File(image!.path);
      setState(() {});
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }

  @override
  void initState() {
    // TODO: implement initState
    getthesharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: AppWidget.boldTextFieldStyle(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      body: email == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: selectedimage == null
                            ? GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: image == null
                                    ? ClipOval(
                                        child: Image.asset("images/profie.png",
                                            height: 160.0,
                                            width: 160.0,
                                            fit: BoxFit.cover),
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          image!,
                                          height: 160.0,
                                          width: 160.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              )
                            : ClipOval(
                                child: Image.file(
                                  selectedimage!,
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              )),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_2_outlined,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: AppWidget.lightTextStyle(),
                                    ),
                                    Text(
                                      "Riyas.F",
                                      style: AppWidget.SemiBoldTextStyle(),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 3.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "email",
                                      style: AppWidget.lightTextStyle(),
                                    ),
                                    Text(
                                      email.toString(),
                                      style: AppWidget.SemiBoldTextStyle(),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(11),
                        elevation: 3,
                        child: GestureDetector(
                          onTap: () {
                            AuthMethods().SignOut().then((_) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              });
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Logout",
                                  style: AppWidget.SemiBoldTextStyle(),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(11),
                        elevation: 3,
                        child: GestureDetector(
                          onTap: () {
                            AuthMethods().deleteUser().then((_) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              });
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Delete Account",
                                  style: AppWidget.SemiBoldTextStyle(),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
