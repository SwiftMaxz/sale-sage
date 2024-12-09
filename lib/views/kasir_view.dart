import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kasir_controller.dart';
import '../widgets/sidebar.dart';

class KasirView extends StatelessWidget {
  final KasirController controller = Get.put(KasirController());

  KasirView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kasir',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.productNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.productName.value = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.productPriceController,
              decoration: const InputDecoration(
                labelText: 'Harga Produk',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  controller.productPrice.value = double.tryParse(value) ?? 0.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addProduct();
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.teal),
              child: const Text('Tambah Produk'),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  'Total Harga: Rp ${controller.totalPrice.value.toStringAsFixed(2)}', // format rupiah
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ListTile(
                        title: Text(product.name),
                        trailing: Text(
                          'Rp ${product.price.toStringAsFixed(2)}', // format rupiah
                          style: const TextStyle(color: Colors.teal),
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _showConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), 
                  textStyle: const TextStyle(fontSize: 18), 
                ),
                child: const Text('Selesaikan Transaksi'), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Selesaikan Transaksi'), 
          content: const Text('Apakah Anda yakin ingin menyelesaikan transaksi ini?'), 
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.red),
              ), 
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); 
                controller.completeTransaction();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
