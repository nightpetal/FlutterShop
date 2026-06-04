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
  late List<dynamic> filteredProducts = [];

  String selectedFilter = 'All';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    products = jsonDecode(productsJson);
    filteredProducts = List.from(products);
  }

  void applyFilters() {
    setState(() {
      filteredProducts = products.where((product) {
        final matchesCategory = selectedFilter == 'All'
            ? true
            : product['category'] == selectedFilter;

        final matchesSearch = product['name'].toString().toLowerCase().contains(
          searchQuery.toLowerCase(),
        );

        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void filterProducts(String filter) {
    selectedFilter = filter;
    applyFilters();
  }

  void searchProducts(String query) {
    searchQuery = query;
    applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        onSearch: searchProducts,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // FILTER ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  filterButton('All'),
                  filterButton('Best Sellers'),
                  filterButton('Recommended'),
                ],
              ),
              const SizedBox(height: 10),

              // PRODUCT GRID
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      name: product['name'],
                      price: product['price'],
                      imageUrl: product['imageUrl'],
                      category: product['category'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterButton(String text) {
    final isSelected = selectedFilter == text;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () => filterProducts(text),
      child: Text(text),
    );
  }
}
