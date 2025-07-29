import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:store_mobile/utils/tools.dart';

import '../models/product.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  State<StatefulWidget> createState() {
    return _ProductItem();
  }
}

class _ProductItem extends State<ProductItem> {
  double? _price;

  void _addToCart() {}


  @override
  void initState() {
    super.initState();
    _price = widget.product.bundles?[0].price;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(CurrencyFormatter.format(_price!, nairaSettings)),
            // const SizedBox(height: 10),
            // DropdownButton<String>(
            //   hint: const Text('Select Variant'),
            //   value: widget.product.bundles[0].unit,
            //   items: (widget.product.bundles).map((bundle) {
            //     return DropdownMenuItem<String>(
            //       value: bundle.id,
            //       child: Text(bundle.unit),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     _onSelectBundle(value!);
            //   },
            // ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: _addToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
