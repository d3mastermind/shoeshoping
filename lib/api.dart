//import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future getProductDetails() async {
  String appid = dotenv.env['APP_ID']!;
  String apikey = dotenv.env['API_KEY']!;
  String orgId = dotenv.env['ORG_ID']!;
  final res = await http.get(
    Uri.parse(
      'https://api.timbu.cloud/products?organization_id=$orgId&Appid=$appid&Apikey=$apikey',
    ),
  );
  final rawProducts = jsonDecode(res.body);
  productCount = rawProducts["total"] as int;
  products = rawProducts["items"];
}

late List<Map<String, Object>> products;
//late List<Map<String, dynamic>> rawProducts;
late int productCount;
late String selectedFilter;

@override
void initState() {
  getProductDetails();
  //raw_products;
  productCount = 0;
}
