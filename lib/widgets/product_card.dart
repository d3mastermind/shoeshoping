import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.bgColor,
  });
  final String title;
  final double price;
  final String imageUrl;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Center(
              child: FadeInImage(
            placeholder: const AssetImage(
              'assets/images/placeholders/shoe_placeholder.png',
            ),
            image: NetworkImage(
              'https://api.timbu.cloud/images/$imageUrl',
            ),
          )),
        ],
      ),
    );
  }
}
