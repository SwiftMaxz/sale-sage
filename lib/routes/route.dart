import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/kasir_view.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String kasir = '/kasir';

  static final routes = [
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: dashboard, page: () => DashboardView()),
    GetPage(name: kasir, page: () => KasirView()),
  ];
}
