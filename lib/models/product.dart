class Bundle {
  const Bundle({
    required this.id,
    required this.unit,
    required this.price,
    required this.enabled,
  });
  final String id;
  final String unit;
  final double price;
  final bool enabled;

}
class Product {
  String? id;
  String? imagePath;
  String? name;
  String? description;
  List<Bundle>? bundles;

  Product({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.bundles,
  });

  Product.fromJson(parsedJson) {
    id = parsedJson['_id'];
    imagePath = parsedJson['imagePath'];
    name = parsedJson['name'];
    description = parsedJson['description'];
    bundles = parsedJson['bundles'].map<Bundle>((bundle) => Bundle(
      id: bundle['_id'],
      unit: bundle['unit'],
      price: bundle['price'] == null ? 0 : bundle['price'].toDouble(),
      enabled: bundle['enabled'],
    )).toList();
  }
}

class Products {
  int? current;
  int? pages;
  int? count;
  int? size;
  int? currentSize;
  List<Product>? products;

  Products({
    required this.current,
    required this.pages,
    required this.count,
    required this.size,
    required this.currentSize,
    required this.products,
  });

  Products.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    pages = json['pages'];
    count = json['count'];
    size = json['size'];
    currentSize = json['current_size'];
    products = json['products']
        .map<Product>((product) => Product.fromJson(product)).toList();
  }
}