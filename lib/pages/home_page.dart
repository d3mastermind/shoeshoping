import "package:flutter/material.dart";
import "package:shopping_app/pages/cart_page.dart";

import "package:shopping_app/pages/product_list.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, Object>> selectedProductList = [];

  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ProductList(
        selectedProductList: selectedProductList,
      ),
      CartPage(
        selectedProductList: selectedProductList,
        currentpage: currentpage,
      ),
    ];
    return Scaffold(
      body: IndexedStack(
        index: currentpage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: currentpage,
        onTap: (value) {
          setState(() {
            currentpage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
