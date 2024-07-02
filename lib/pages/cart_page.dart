import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/pages/order_success_page.dart';

class CartPage extends StatefulWidget {
  const CartPage(
      {super.key,
      required this.currentpage,
      required this.selectedProductList});
  //final Function onAddToCart;
  final List<Map<String, Object>> selectedProductList;
  final int currentpage;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // @override
  // void initState() {
  //   myFunc();
  //   super.initState();
  // }

  // void myFunc() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    //widget.onAddToCart();
    //myFunc();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CART'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.selectedProductList.length,
                itemBuilder: (context, index) {
                  final cartItem = widget.selectedProductList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(
                        cartItem['imageUrl'].toString(),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.selectedProductList.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      cartItem['title'].toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      '\$${cartItem['price'].toString()}',
                    ),
                  );
                }),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return OrderSuccessPage(
                      selectedProductList: widget.selectedProductList,
                    );
                  },
                ),
              );
              setState(() {
                widget.selectedProductList.clear();
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary),
              minimumSize: const MaterialStatePropertyAll(
                Size(250, 50),
              ),
            ),
            child: Text(
              'Checkout',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
