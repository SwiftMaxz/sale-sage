import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/kasir_controller.dart';
import 'controllers/login_controller.dart';
import 'routes/route.dart';

void main() {
  Get.put(KasirController()); // Inisiasi KasirController
  Get.put(LoginController()); // Inisiasi LoginController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS App',
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
