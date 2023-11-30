import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Productes {
     RxList<Product> products;

    Productes({
        required this.products,
    });

    factory Productes.fromJson(String str) => Productes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Productes.fromMap(Map<String, dynamic> json) => Productes(
        products: RxList<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
    };
}

class Product {
    String image;
    int price;

    Product({
        required this.image,
        required this.price,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        image: json["image"],
        price: json["price"],
    );

    Map<String, dynamic> toMap() => {
        "image": image,
        "price": price,
    };
}