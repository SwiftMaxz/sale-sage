import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/sidebar.dart';
import '../controllers/login_controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final LoginController loginController = Get.find<LoginController>();

  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang, ${loginController.username.value}!', // Welcome message
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Obx(() => _InfoCard(
                      title: "Total Penjualan",
                      value: "Rp ${controller.totalSales.toStringAsFixed(2)}",  // format rupiah
                      color: Colors.teal,
                    )),
                const SizedBox(height: 16),
                Obx(() => _InfoCard(
                      title: "Total Transaksi",
                      value: "${controller.totalTransactions}",
                      color: Colors.orange,
                    )),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Grafik Penjualan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Obx(() {
                if (controller.dailySalesData.isEmpty) {
                  return const Center(
                    child: Text("Data penjualan tidak tersedia"),
                  );
                }
                return LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.dailySalesData
                            .asMap()
                            .entries
                            .map((entry) =>
                                FlSpot(entry.key.toDouble(), entry.value))
                            .toList(),
                        isCurved: true,
                        barWidth: 3,
                        colors: [Colors.teal],
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [Colors.teal.withOpacity(0.3)],
                        ),
                      ),
                    ],
                    borderData: FlBorderData(
                      border: const Border(
                        bottom: BorderSide(),
                        left: BorderSide(),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _InfoCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

