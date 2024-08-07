import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  addProduct(Map<String, dynamic> userInfoMap, String catogoryName) async {
    await FirebaseFirestore.instance.collection(catogoryName).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getProducts(String catogory) async {
    return await FirebaseFirestore.instance.collection(catogory).snapshots();
  }

  Future orderDetails(Map<String, dynamic> prodtailsMap) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .add(prodtailsMap);
  }

  Future<Stream<QuerySnapshot>> getOrders({required String? email}) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .where("email", isEqualTo: email)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> allOrders() async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .where("Status", isEqualTo: "On the way")
        .snapshots();
  }

  updateOrder({required String DocId}) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(DocId)
        .update({"Status": "Delivered"});
  }

  Future addAllProducts(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(userInfoMap);
  }

  // Future<QuerySnapshot> search(String updatedname) async {
  //   return await FirebaseFirestore.instance
  //       .collection("Products")
  //       .where("SearchKey",
  //           isEqualTo: updatedname.substring(0, 1).toUpperCase())

  //       .get();
  // }

  Future<QuerySnapshot> search(String updatedname) async {
    String searchKey = updatedname.substring(0, 1).toUpperCase();
    print("Searching for products with SearchKey: $searchKey"); // Debug print

    try {
      return await FirebaseFirestore.instance
          .collection("Products")
          .where("SearchKey", isEqualTo: searchKey)
          .get();
    } catch (e) {
      print("Error occurred during search: $e");
      rethrow; // Optionally rethrow the error after logging it
    }
  }
}
