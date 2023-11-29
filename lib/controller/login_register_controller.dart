import 'package:get/get.dart';

class LoginOrRegisterController extends GetxController {
  RxBool isLogin = true.obs;
  RxBool isRegister = false.obs;
  RxBool isChecked = false.obs;

  RxString correo = ''.obs;
  RxString passwd = ''.obs;
  RxString mensaje = ''.obs;

  RxBool isLoading = false.obs;

  void toggleLoginOrRegister() {
    isLogin.value = !isLogin.value;
    isRegister.value = !isRegister.value;
  }

  Future<void> loginRegisterRequest() async {
    if (_validate()) {
      isLoading.value = true;
      // Simulación de la petición de login a la API o similar
      await Future.delayed(const Duration(seconds: 2));

      if (mensaje.value.isEmpty) {
        //quiere decir que no ha habido ningun error.
        Get.offAllNamed(
            '/products'); // Cambiar a Get.toNamed('/products') si no queremos reemplazar una pantalla por otra en la pila
      } else {
        print({mensaje.value});
        Get.snackbar('Error', mensaje.value);
      }

      isLoading.value = false;
    }
  }

  bool _validate() {
    if (correo.value.isEmpty) {
      mensaje.value = "Correu és obligatori";
      return false;
    } else if (!RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$')
        .hasMatch(correo.value)) {
      mensaje.value = "Format correu incorrecte";
      return false;
    } else if (passwd.value.isEmpty) {
      mensaje.value = "Contrasenya és obligatori";
      return false;
    } else if (passwd.value.length <= 5) {
      mensaje.value = "Contrasenya mínim de 5 caràcters";
      return false;
    } else if (!RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$').hasMatch(passwd.value)) {
      mensaje.value = "Contrasenya incorrecte";
      return false;
    }
    mensaje.value = '';
    return true;
  }
}
