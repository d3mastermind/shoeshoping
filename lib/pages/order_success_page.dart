import 'package:flutter/material.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({
    super.key,
    required this.selectedProductList,
  });
  final List<Map<String, Object>> selectedProductList;

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 200,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              'Order Successfull',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(255, 220, 255, 1))),
                child: Text(
                  'Continue Shopping',
                  style: Theme.of(context).textTheme.titleMedium,
                ))
          ],
        ),
      ),
    );
  }
}
