import 'dart:io';

import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  String? value;
  final List<String> categoryitem = ['watch', 'laptop', 'Tv', 'Headphones'];

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedimage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedimage != null && _namecontroller.text != "") {
      try {
        String RandomId = randomAlphaNumeric(10);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("blogImage").child(RandomId);

        final UploadTask task = firebaseStorageRef.putFile(selectedimage!);
        var downloadURl = await (await task).ref.getDownloadURL();
        String firstletter = _namecontroller.text.substring(0, 1).toUpperCase();

        Map<String, dynamic> addProduct = {
          "Name": _namecontroller.text,
          "Image": downloadURl,
          "SearchKey": firstletter,
          "UpdatedName": _namecontroller.text.toUpperCase(),
          "Price": _pricecontroller.text,
          "Details": _detailcontroller.text
        };

        await DatabaseMethods().addProduct(addProduct, value!).then((_) async {
          await DatabaseMethods().addAllProducts(addProduct).then((value) {
            setState(() {
              selectedimage = null;
              _namecontroller.text = "";
              _pricecontroller.text = "";
              _detailcontroller.text = "";
              this.value = null;
            });

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: const Text(
                "Product has been Uploaded Sucessfully",
                style: TextStyle(fontSize: 20.0),
              ),
            ));
          }).catchError((error) {
            print("Error adding product to all products: $error");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Failed to add product to all products: $error",
                style: TextStyle(fontSize: 20.0),
              ),
            ));
          });
        }).catchError((error) {
          print("Error adding product: $error");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Failed to add product: $error",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        });
      } catch (e) {
        print("Error uploading item: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "Error uploading item: $e",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      }
    }
  }

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
                    : GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
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
                        setState(() {});
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
