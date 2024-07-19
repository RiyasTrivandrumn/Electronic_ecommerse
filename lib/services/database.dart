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
}
