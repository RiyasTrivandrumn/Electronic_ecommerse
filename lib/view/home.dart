import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elec_e_comm/services/database.dart';
import 'package:elec_e_comm/view/product_catogory.dart';
import 'package:elec_e_comm/view/product_details.dart';
import 'package:elec_e_comm/view/widgets/all_products_tile.dart';
import 'package:elec_e_comm/view/widgets/support_widget.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> price = ["300", "400", "700"];
  bool search = false;

  List<String> catogory = [
    "images/headphone_icon.png",
    "images/watch.png",
    "images/TV.png",
    "images/laptop.png"
  ];
  List<String> catogoryName = ["Headphones", "watch", "Tv", "laptop"];
  var queryResultSet = [];
  var tempSearchStore = [];

  List<String> allProducts = [
    "images/headphone2.png",
    "images/laptop2.png",
    "images/watch2.png"
  ];

  List<String> names = ["Head Phone", "Acer Laptop", "Apple Watch"];

  // initiateSearch(value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       queryResultSet = [];
  //       tempSearchStore = [];
  //     });
  //   }
  //   setState(() {
  //     search = true;
  //   });
  //   var capitalizedValue =
  //       value.substring(0, 1).toUpperCase() + value.substring(1);
  //   print(capitalizedValue);
  //   if (queryResultSet.isEmpty && value.length == 1) {
  //     DatabaseMethods().search(value).then((QuerySnapshot docs) {
  //       for (int i = 0; i < docs.docs.length; i++) {
  //         queryResultSet.add(docs.docs[i].data());
  //         print(docs.docs[i].data());
  //       }
  //     });
  //   } else {
  //     tempSearchStore = [];
  //     queryResultSet.forEach((element) {
  //       if (element['UpdatedName'].startsWith(capitalizedValue)) {
  //         setState(() {
  //           tempSearchStore.add(element);
  //         });
  //       }
  //     });
  //   }
  // }

  void initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
      return;
    }

    setState(() {
      search = true;
    });

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    print(capitalizedValue); // Debug print

    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        print(
            "Search completed, number of documents found: ${docs.docs.length}");
        if (docs.docs.isNotEmpty) {
          for (int i = 0; i < docs.docs.length; i++) {
            var data = docs.docs[i].data();
            queryResultSet.add(data);
            tempSearchStore = [];
            queryResultSet.forEach((element) {
              if (element['UpdatedName'].startsWith(capitalizedValue)) {
                setState(() {
                  tempSearchStore.add(element);
                  print(tempSearchStore);
                });
              }
            });
            print(data); // Debug print
          }
        } else {
          print("No documents found for the search value: $value");
        }
      }).catchError((error) {
        print("Error occurred during search: $error");
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['UpdatedName'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 235, 235),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey, Riyas", style: AppWidget.boldTextFieldStyle()),
                      Text(
                        "Good Morning",
                        style: AppWidget.lightTextStyle(),
                      ),
                    ],
                  ),
                  Container(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "images/boy.jpg",
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20.0),
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      initiateSearch(value.toUpperCase());
                    },
                    decoration: InputDecoration(
                        prefixIcon: search
                            ? GestureDetector(
                                onTap: () {
                                  search = false;
                                  tempSearchStore = [];
                                  queryResultSet = [];
                                  searchController.clear();
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              )
                            : Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                        border: InputBorder.none,
                        hintText: "Search Products",
                        hintStyle: AppWidget.lightTextStyle()),
                  )),
              SizedBox(
                height: 20,
              ),
              search
                  ? ListView(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return buildResultCard(element);
                      }).toList(),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Categories",
                                style: AppWidget.SemiBoldTextStyle(),
                              ),
                              Text(
                                "see all",
                                style: TextStyle(
                                    color: Color.fromARGB(
                                      255,
                                      240,
                                      165,
                                      52,
                                    ),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 120,
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 208, 142, 41),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 130,
                                    width: 80,
                                    child: Center(
                                        child: Text(
                                      "All",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ))),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: catogory.length,
                                    itemBuilder: (context, index) {
                                      return CatogoryTile(
                                          image: catogory[index],
                                          name: catogoryName[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Products",
                                style: AppWidget.SemiBoldTextStyle(),
                              ),
                              Text(
                                "see all",
                                style: TextStyle(
                                    color: Color.fromARGB(
                                      255,
                                      240,
                                      165,
                                      52,
                                    ),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 220,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: allProducts.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return AllProductsTile(
                                  image: allProducts[index],
                                  title: names[index],
                                  price: price[index],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                    name: data["Name"],
                    image: data["Image"],
                    price: data["Price"],
                    details: data["Details"])));
      }),
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data["Image"],
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              data["Name"],
              style: AppWidget.SemiBoldTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}

class CatogoryTile extends StatelessWidget {
  final String image;
  final String name;
  const CatogoryTile({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductCatogory(
                      catogory: name,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
            Icon(Icons.arrow_forward_sharp)
          ],
        ),
      ),
    );
  }
}
