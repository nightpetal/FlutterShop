import 'package:flutter/material.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 120,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopify_rounded),
              Text("Shop App"),
            ],
          ),

          SizedBox(
            height: 8,
          ),

          SizedBox(
            width: double.infinity,
            child: SearchBar(
              hintText: "Search",
              leading: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
