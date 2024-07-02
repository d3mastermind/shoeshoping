import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.selectedProductList,
  });
  final Map<String, Object> product;
  final List<Map<String, Object>> selectedProductList;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int sizee;

  @override
  void initState() {
    sizee = 0;
    super.initState();
  }

  int cartno = 1;
  @override
  Widget build(BuildContext context) {
    Map<String, Object> selectedProduct = {
      'id': widget.product['id'] as String,
      'title': widget.product['title'] as String,
      'price': widget.product['price'] as double,
      'imageUrl': widget.product['imageUrl'] as String,
      'company': widget.product['company'] as String,
      'size': sizee,
    };

    onAddToCart() {
      setState(() {
        widget.selectedProductList.add(selectedProduct);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Column(children: [
        Center(
          child: Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(widget.product['imageUrl'] as String),
        ),
        const Spacer(
          flex: 2,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 220, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Text(
                '\$${widget.product['price']}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.product['sizes'] as List<int>).length,
                  itemBuilder: (context, index) {
                    final size = (widget.product['sizes'] as List<int>)[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          sizee = size;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Chip(
                          backgroundColor: sizee == size
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromARGB(255, 248, 234, 248),
                          label: Text(
                            '$size',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (sizee == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select shoe size'),
                      ),
                    );
                  } else {
                    onAddToCart();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Product added to cart'),
                    ));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add to Cart',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
