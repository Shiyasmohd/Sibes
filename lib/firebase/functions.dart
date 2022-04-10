import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/food_model.dart';

class FireBaseFunctions {
  FireBaseFunctions._internal();
  static FireBaseFunctions instance = FireBaseFunctions._internal();
  factory FireBaseFunctions() {
    return instance;
  }

  ValueNotifier<List<FoodModel>> foodListNotifier = ValueNotifier([]);

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    // _list.sort((first, second) => second.time.compareTo(first.time));
    foodListNotifier.value.clear();
    foodListNotifier.value.addAll(_list);
    print("hello World");
    foodListNotifier.notifyListeners();
  }

  Future<List<FoodModel>> getAllTransactions() async {
    late List<FoodModel> f1 = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> f2;
    await FirebaseFirestore.instance.collection("products").get().then(
        (value) => {
          f2 = value.docs..map((e) => f1.add(FoodModel.fromMap1(e))).toList()
         
          });
    print("f1 is $f1");
    return f1;
  }
}
