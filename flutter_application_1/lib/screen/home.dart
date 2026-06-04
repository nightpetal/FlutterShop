import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/nav_bar.dart';
import 'package:flutter_application_1/widgets/product_card.dart';
import '../data/product_data.dart'; // your JSON file

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    products = jsonDecode(productsJson); // parse your JSON list here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65, // slightly smaller to avoid overflow
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                name: product['name'],
                price: product['price'],
                imageUrl: product['imageUrl'],
                category: product['category'],
              );
            },
          ),
        ),
      ),
    );
  }
}
