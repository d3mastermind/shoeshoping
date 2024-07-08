import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/pages/order_success_page.dart';
import 'package:shopping_app/pages/cart_page_with_product.dart';

class CartPage extends StatefulWidget {
  const CartPage(
      {super.key, required this.pageReset, required this.selectedProductList});
  //final Function onAddToCart;
  final List<Map<String, Object>> selectedProductList;
  final Function pageReset;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    //widget.onAddToCart();
    //myFunc();
    List<Map<String, Object>> selectedProductList = widget.selectedProductList;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CART'),
      ),
      body: Column(
        children: [
          widget.selectedProductList.isEmpty
              ? const Image(
                  image: AssetImage(
                      'assets/images/placeholders/shop_placeholder.png'))
              : CartPageWithProduct(selectedProductList: selectedProductList),
          widget.selectedProductList.isEmpty
              ? TextButton.icon(
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(250, 50),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.pageReset(0);
                    });
                  },
                  label: Text(
                    'Back to Shopping',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              : TextButton(
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
