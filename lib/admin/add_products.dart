import 'dart:io';

import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProdut extends StatefulWidget {
  const AddProdut({super.key});

  @override
  State<AddProdut> createState() => _AddProdutState();
}

class _AddProdutState extends State<AddProdut> {
  final ImagePicker _picker = ImagePicker();
  File? selectedimage;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _pricecontroller = TextEditingController();
  TextEditingController _detailcontroller = TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedimage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedimage != null && _namecontroller.text != "") {
      String RandomId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(RandomId);

      final UploadTask task = firebaseStorageRef.putFile(selectedimage!);
      var downloadURl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> addProduct = {
        "Name": _namecontroller.text,
        "Image": downloadURl,
        "Price": _pricecontroller.text,
        "Details": _detailcontroller.text
      };
      await DatabaseMethods().addProduct(addProduct, value!).then(() {
        selectedimage = null;
        _namecontroller.text = "";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: const Text(
            "Product has been Uploaded Sucessfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      });
    }
  }

  String? value;
  final List<String> categoryitem = ['watch', 'laptop', 'Tv', 'Headphones'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_sharp)),
        centerTitle: true,
        title: Text(
          "Add Product",
          style: AppWidget.SemiBoldTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Product Image",
                style: AppWidget.lightTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: selectedimage == null
                    ? GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          child: Icon(Icons.camera_alt_outlined),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            selectedimage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Product Name",
                style: AppWidget.lightTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 240, 236, 236),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _namecontroller,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Product Price",
                style: AppWidget.lightTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 240, 236, 236),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _pricecontroller,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Product Detail",
                style: AppWidget.lightTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 240, 236, 236),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    maxLines: 6,
                    controller: _detailcontroller,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Product Catogory",
                style: AppWidget.lightTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 236, 236),
                    borderRadius: BorderRadius.circular(15)),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoryitem.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                    dropdownColor: Colors.white,
                    hint: const Text("Select Catogory"),
                    value: value,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        uploadItem();
                      },
                      child: Text(
                        "Add Product",
                        style: TextStyle(fontSize: 20),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
