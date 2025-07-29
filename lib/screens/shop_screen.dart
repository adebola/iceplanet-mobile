import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/tools.dart';
import '../widgets/product_item.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<dynamic> products = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  Map<int, String> selectedVariants = {}; // To store selected variants for each product
  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://store.factorialsystems.io/api/v1/product'));
    logger.d(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> fetchedProducts = json.decode(response.body);
      setState(() {
        products.addAll(fetchedProducts);
        isLoading = false;
        hasMore = fetchedProducts.isNotEmpty;
        page++;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              hasMore &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadProducts();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: products.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == products.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final product = products[index];
            return ProductItem(
              product: product,
            );
          },
        ),
      ),
    );
  }
}