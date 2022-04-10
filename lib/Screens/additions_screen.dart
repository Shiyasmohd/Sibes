import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/food_model.dart';

class AdditionScreen extends StatelessWidget {
  const AdditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Your Active Donations", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),),
            SizedBox(height: 30,),
            Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where("userId", isEqualTo: _auth?.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Image.asset(
                        "assets/loading-food.gif",
                        height: 250.0,
                        width: 250.0,
                      ),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      final _temp = FoodModel.fromMap1(document);
                      return Card(
                          elevation: 1,
                          child: ListTile(
                            leading: SizedBox(
                              
                                child: Image(image: NetworkImage(_temp.url), fit: BoxFit.contain, )),
                            title: Text(_temp.name),
                            subtitle: Text(_temp.type),
                            trailing: IconButton(
                                onPressed: () {
                                  handleClick(_temp, context);
                                },
                                icon: const Icon(Icons.delete_forever)),
                          ));
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleClick(FoodModel _temp, BuildContext ctx) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    FirebaseStorage.instance.refFromURL(_temp.url);
    await products
        .doc(_temp.itemId)
        .delete()
        .then((value) => print("item Deleted"))
        .catchError((error) => print("Failed to delete item: $error"));
  }


}
