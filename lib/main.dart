import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Trans;
import 'package:testing_bluetooth_thermal/pages/print_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<Permission, PermissionStatus> statuses = await [
    // Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.location,
    Permission.storage,
    Permission.camera,
    Permission.storage,
  ].request();
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.blueAccent,
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',
  // ignore: prefer_const_constructors
  textTheme: TextTheme(
    headline1: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class AppController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}

class App extends StatelessWidget {
  final controller = Get.put(AppController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Testing Bluetooth Thermal",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: appThemeData,
      defaultTransition: Trans.Transition.fadeIn,
      getPages: [
        GetPage(name: "/", page: () => PrintPage()),
      ],
    );
  }
}
