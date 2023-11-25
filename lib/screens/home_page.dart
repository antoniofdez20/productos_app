import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Formulario de inicio de sesión

            ElevatedButton(
              onPressed: () {
                // Aquí deberías realizar la lógica de inicio de sesión
                // Por ejemplo, verificar credenciales, etc.
                // Si la sesión es exitosa, navegar a la página de productos.
                Get.to(const ProductsScreen());
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
