import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class KasirController extends GetxController {
  var productName = ''.obs;
  var productPrice = 0.0.obs;
  var products = <Product>[].obs;
  var totalPrice = 0.0.obs;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  // State global untuk Dashboard
  var totalSales = 0.0.obs;
  var totalTransactions = 0.obs;
  var dailySalesData = <double>[].obs;

  void addProduct() {
    if (productName.value.isNotEmpty && productPrice.value > 0) {
      products.add(Product(name: productName.value, price: productPrice.value));
      totalPrice.value += productPrice.value;
      productName.value = '';
      productPrice.value = 0.0;

      // Reset input fields
      productNameController.clear();
      productPriceController.clear();
    }
  }

  void completeTransaction() {
    if (products.isNotEmpty) {
      // Tambah data ke global state
      totalSales.value += totalPrice.value;
      totalTransactions += 1;
      dailySalesData.add(totalPrice.value);

      products.clear();
      totalPrice.value = 0.0;
      Get.snackbar("Transaksi Selesai", "Semua produk telah direset!");
    } else {
      Get.snackbar("Tidak ada produk", "Tambahkan beberapa produk sebelum menyelesaikan transaksi!");
    }
  }
}
