import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productos_app/controller/login_register_controller.dart';

class HomeScreen extends StatelessWidget {
  final LoginOrRegisterController controller =
      Get.put(LoginOrRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                child: AnimatedLogo(),
              ),
              Obx(() {
                return controller.isLogin.value || controller.isRegister.value
                    ? loginOrRegisterForm()
                    : const SizedBox.shrink();
              }),
              const SizedBox(height: 100),
              loginOrRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginOrRegister() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        controller.toggleLoginOrRegister();
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.blue[800],
      selectedColor: Colors.white,
      fillColor: Colors.blue[200],
      color: Colors.blue[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 120.0,
      ),
      isSelected: [controller.isLogin.value, controller.isRegister.value],
      children: events,
    );
  }

  Widget loginOrRegisterForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Obx(() {
          return Text(
              controller.isLogin.value ? 'Inicia sessió' : 'Registra\'t');
        }),
        Container(
          width: 300.0,
          child: Form(
            child: Column(
              children: <Widget>[
                Obx(() {
                  return TextFormField(
                    initialValue: controller.correo.value,
                    onChanged: (value) => controller.correo.value = value,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Correu es obligatori";
                      } else if (!RegExp(
                              r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$')
                          .hasMatch(text)) {
                        return "Format correu incorrecte";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Escrigui el seu correu',
                      labelText: 'Correu',
                      counterText: '',
                      icon: Icon(Icons.email,
                          size: 32.0, color: Colors.blue[800]),
                    ),
                  );
                }),
                Obx(() {
                  return TextFormField(
                    initialValue: controller.passwd.value,
                    onChanged: (value) => controller.passwd.value = value,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Contrasenya és obligatori";
                      } else if (text.length <= 5) {
                        return "Contrasenya mínim de 5 caràcters";
                      } else if (!RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$')
                          .hasMatch(text)) {
                        return "Contrasenya incorrecte";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Escrigui la contrasenya',
                      labelText: 'Contrasenya',
                      counterText: '',
                      icon:
                          Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                    ),
                  );
                }),
                Obx(() {
                  return controller.isLogin.value
                      ? CheckboxListTile(
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value = value!;
                          },
                          title: const Text('Recorda\'m'),
                          controlAffinity: ListTileControlAffinity.leading,
                        )
                      : const SizedBox(height: 56);
                }),
                IconButton(
                  onPressed: () => controller.loginRegisterRequest(),
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                ),
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Container();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedLogo extends GetView<LoginOrRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Opacity(
        opacity: controller.isLoading.value ? 0.1 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: controller.isLoading.value ? 0.0 : 100.0,
          width: controller.isLoading.value ? 0.0 : 100.0,
          child: const FlutterLogo(),
        ),
      );
    });
  }
}

const List<Widget> events = <Widget>[
  Text('Inicia sessió'),
  Text('Registra\'t'),
];
