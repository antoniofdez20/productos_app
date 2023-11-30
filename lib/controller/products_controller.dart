import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:productos_app/controller/productes.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class ProductsController extends GetxController {
  String _baseUrl =
      "api-tenda-7058f-default-rtdb.europe-west1.firebasedatabase.app";

  RxList<Product> onProductes = <Product>[].obs;
  RxList<Product> selectedProducts = <Product>[].obs;
   RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("ProductsController iniciado");
    getDisplayProductes();
  }

  Future<void> getDisplayProductes() async {
  print('getDisplayProductes');
  var url = Uri.https(_baseUrl, '/.json');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final products = Productes.fromJson(response.body);

      // Utiliza update para forzar la actualizaciÃ³n de la interfaz de usuario
      onProductes.assignAll(products.products);
      update();
      print("Productos obtenidos: ${onProductes.length}");
    } else {
      print('Error en getDisplayProductes - StatusCode: ${response.statusCode}');
    }
  } catch (error) {
    print('Error en getDisplayProductes: $error');
  }
}


  void selectProduct(Product product) {
    selectedProducts.add(product);
    updateTotalPrice();
    update();
  }

  void deselectProduct(Product selectedProduct) {
    selectedProducts.remove(selectedProduct);
    updateTotalPrice();
    update();
  }

  int calculateProductCount(Product product) {
    return selectedProducts.where((p) => p == product).length;
  }


  void updateTotalPrice() {
    int total = 0;
    for (Product product in selectedProducts) {
      total += product.price;
    }
    totalPrice.value = total;
  }

}