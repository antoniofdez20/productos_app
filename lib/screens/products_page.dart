import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productos_app/controller/productes.dart';
import 'package:productos_app/controller/products_controller.dart';

class ProductsScreen extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos App'),
      ),
      body: Column(
        children: [
          // Lista de Compra
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Lista de Compra'),
                Obx(
                  () => ProductList(productsController.onProductes),
                ),
              ],
            ),
          ),

          // Cesta
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cesta'),
                Obx(
                  () => buildProductList(productsController.selectedProducts),
                ),
                SizedBox(height: 16),
                
           Obx(
                () => Text(
                  'Precio Total: \$${productsController.totalPrice}',
                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ProductList(RxList<Product> productList) {
    return Expanded(
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          var product = productList[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${product.price.toString()}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // Lógica para quitar producto
                        // Usa GetX para actualizar el estado
                        productsController.deselectProduct(product);
                      },
                    ),
                    Obx(
                      () => Text(
                        '${calculateProductCount(product)}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Lógica para añadir producto
                        // Usa GetX para actualizar el estado
                        productsController.selectProduct(product);
                      },
                    ),
                  ],
                ),
              ],
            ),

          );
        },
      ),
    );
  }

  Widget buildProductList(RxList<Product> productList) {
    return Expanded(
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          var product = productList[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${product.price.toString()}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  product.price.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  int calculateProductCount(Product product) {
    return productsController.selectedProducts.where((p) => p == product).length;
  }

  String calculateTotalPrice(RxList<Product> selectedProducts) {
    int totalPrice = 0;
    for (var product in selectedProducts) {
      totalPrice += product.price;
    }
    return totalPrice.toString();
  }
}

