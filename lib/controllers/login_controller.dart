import 'package:get/get.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;

  void login() {
    if (username.value.isEmpty || password.value.isEmpty) {
      errorMessage.value = "Username dan Password tidak boleh kosong!";
    } else if (username.value == 'Gery' && password.value == 'admin76') {
      errorMessage.value = "";
      Get.offNamed('/dashboard');
    } else {
      errorMessage.value = "Username atau Password salah!";
    }
  }
}
