import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final dynamic product;
  final VoidCallback onAddToCart;
  final String? selectedVariant;
  final ValueChanged<String> onVariantSelected;

  const ProductItem({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.selectedVariant,
    required this.onVariantSelected,
  });

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
              product['name'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Price: \$${product['price']}'),
            const SizedBox(height: 10),
            DropdownButton<String>(
              hint: const Text('Select Variant'),
              value: selectedVariant,
              items: (product['variants'] as List<dynamic>).map((variant) {
                return DropdownMenuItem<String>(
                  value: variant['name'],
                  child: Text(variant['name']),
                );
              }).toList(),
              onChanged: (value) {
                onVariantSelected(value!);
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: onAddToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}