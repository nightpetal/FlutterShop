import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust image height based on screen width
    final imageHeight = screenWidth * 0.4; // 40% of screen width

    // Adjust font sizes based on screen width
    final nameFontSize = screenWidth * 0.045; // ~16 on a 360 width screen
    final categoryFontSize = screenWidth * 0.03; // ~12 on a 360 width screen
    final priceFontSize = screenWidth * 0.045; // ~16 on a 360 width screen

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(screenWidth * 0.02), // responsive margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: imageHeight,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: screenWidth * 0.14, color: Colors.grey),
              ),
            ),
          ),

          // NAME & CATEGORY
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: nameFontSize,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: categoryFontSize,
                  ),
                ),
              ],
            ),
          ),

          // PRICE
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025,
              vertical: screenWidth * 0.01,
            ),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: priceFontSize,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}