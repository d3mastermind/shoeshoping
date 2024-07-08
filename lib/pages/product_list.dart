import 'dart:convert';

import 'package:flutter/material.dart';
//import "package:shopping_app/global_variables.dart";
import "package:shopping_app/widgets/product_card.dart";
import "package:shopping_app/pages/product_details_page.dart";
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.selectedProductList});
  final List<Map<String, Object>> selectedProductList;
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    "All",
    "Bata",
    "Knike",
    "Abiba",
  ];
  String? error;
  bool isloading = true;
  List<dynamic> products = [];
  //late List<Map<String, dynamic>> rawProducts;
  int productCount = 0;
  late String selectedFilter;

  Future getProductDetails() async {
    isloading = true;
    await dotenv.load(fileName: ".env.secrets");
    String appid = dotenv.env['APP_ID']!;
    String apikey = dotenv.env['API_KEY']!;
    String orgId = dotenv.env['ORG_ID']!;
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.timbu.cloud/products?organization_id=$orgId&Appid=$appid&Apikey=$apikey',
        ),
      );
      final rawProducts = jsonDecode(res.body);
      setState(() {
        productCount = rawProducts["total"] as int;
        products = rawProducts["items"];
        error = null;
        isloading = false;
      });
      //setState(() {});
    } catch (e) {
      setState(() {
        error = e.toString();
        isloading = false;
      });
    } //finally {

    // }
  }

  @override
  void initState() {
    products = [];
    selectedFilter = filters[0];
    getProductDetails();
    productCount = 0;
    isloading;
    super.initState();
  }

  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(225, 225, 225, 1),
    ),
    borderRadius: BorderRadius.horizontal(
      left: Radius.circular(25),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: border,
                    enabledBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(255, 220, 255, 1),
                        width: 0.3,
                      ),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromARGB(255, 248, 234, 248),
                      label: Text(
                        filter,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                  ),
                );
              },
            ),
          ),
          isloading
              ? const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : productCount == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          color: Theme.of(context).colorScheme.primary,
                          Icons.error,
                          size: 200,
                        ),
                        Text(
                          'An Error Occured',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.primary),
                              minimumSize: const MaterialStatePropertyAll(
                                Size(300, 50),
                              ),
                            ),
                            onPressed: () {
                              getProductDetails();
                              setState(() {});
                              //getProductDetails();
                            },
                            child: Text(
                              'Try Again',
                              style: Theme.of(context).textTheme.titleMedium,
                            ))
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: productCount,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsPage(
                                          product: product,
                                          //nAddToCart: ,
                                          selectedProductList:
                                              widget.selectedProductList,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ProductCard(
                                  title: product['name'] as String,
                                  price: product['current_price'][0]['NGN'][0]
                                      as double,
                                  imageUrl: (product['photos'] as List)[0]
                                      ['url'] as String,
                                  bgColor: index.isEven
                                      ? const Color.fromRGBO(255, 220, 255, 1)
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          }),
                    )
        ],
      ),
    );
  }
}
