import 'package:get/get.dart';
import 'package:pos_app/controllers/kasir_controller.dart';

class DashboardController extends GetxController {
  final KasirController kasirController = Get.find<KasirController>();

  double get totalSales => kasirController.totalSales.value;
  int get totalTransactions => kasirController.totalTransactions.value;
  List<double> get dailySalesData => kasirController.dailySalesData;
}
