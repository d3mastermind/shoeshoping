import 'package:flutter/material.dart';

class CartPageWithProduct extends StatefulWidget {
  const CartPageWithProduct({
    super.key,
    required this.selectedProductList,
  });
  final List<Map<String, Object>> selectedProductList;

  @override
  State<CartPageWithProduct> createState() => _CartPageWithProductState();
}

class _CartPageWithProductState extends State<CartPageWithProduct> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.selectedProductList.length,
          itemBuilder: (context, index) {
            final cartItem = widget.selectedProductList[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  'https://api.timbu.cloud/images/${cartItem['imageUrl']}',
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    widget.selectedProductList.removeAt(index);
                  });

                  if (widget.selectedProductList.isEmpty) {
                    setState(() {
                      widget.selectedProductList.clear();
                    });
                  }
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
    );
  }
}
