import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoriesServices {
  FirebaseFirestore? _instance;

  final List<Category> _categories = [];

  List<Category> getCategories() => _categories;

  Future<Void?> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    CollectionReference categories = _instance!.collection('Books');

    DocumentSnapshot snapshot = await categories.doc('categories').get();
    var data = snapshot.data() as Map;

    var categoriesData = data['categories'] as List<dynamic>;

    categoriesData.forEach((catData) {
      //convert each data into model
    });
  }
}
