import 'package:kfc/model/product_model.dart';

class CategoryModel {
  String name;
  String icon;
  final List<ProductModel> products;
  bool selected;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.products,
    this.selected = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<ProductModel> productList = productsFromJson
        .map((product) => ProductModel.fromJson(product))
        .toList();

    return CategoryModel(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      products: productList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsToJson =
        products.map((product) => product.toJson()).toList();

    return {
      'name': name,
      'icon': icon,
      'products': productsToJson,
    };
  }
}
