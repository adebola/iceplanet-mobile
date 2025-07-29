import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:store_mobile/utils/tools.dart';
import 'package:store_mobile/widgets/product_item.dart';

import '../models/product.dart';

class ShopScreen2 extends StatefulWidget {
  const ShopScreen2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShopScreen2State();
  }
}

class _ShopScreen2State extends State<ShopScreen2> {
  Future<http.Response>? _data;


  @override
  void initState() {
    super.initState();
    final baseUrl = dotenv.env['AWS_BUCKET_NAME']!;
    _data = http.get(Uri.parse('$baseUrl/product'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shop'),
        ),
        body: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.error != null) {
                  logger.e(snapshot.error);
                  return const Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  final p = json.decode(snapshot.data!.body);
                  final products = p['products'];
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final bundles = products[index]['bundles']
                          .map((bundle) {
                            int? price = bundle['price'];

                            return Bundle(
                              id: bundle['_id'],
                              unit: bundle['unit'],
                              price: price == null ? 0.0 : price.toDouble(),
                              enabled: bundle['enabled'] as bool,
                            );
                          })
                          .toList()
                          .cast<Bundle>();

                      var p = Product(
                          id: products[index]['_id'],
                          imagePath: products[index]['imagePath'],
                          name: products[index]['name'],
                          description: products[index]['description'],
                          bundles: bundles);
                      return ProductItem(product: p);
                    },
                  );
                }
              }
            }));
  }
}
