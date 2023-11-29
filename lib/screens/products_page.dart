import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productos_app/controller/products_controller.dart';

class ProductsScreen extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Bienvenido a la página de productos!'),

            // Aquí puedes mostrar la lista de productos u otras cosas relacionadas con los productos.
          ],
        ),
      ),
    );
  }
}
