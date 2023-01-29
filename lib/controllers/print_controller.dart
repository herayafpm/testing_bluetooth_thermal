import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PrintController extends GetxController {
  final pengaturans = [].obs;
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  final devices = [].obs;
  @override
  void onInit() async {
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
    ].request();
    initPlatformState();
    printerPrint(null);
    super.onInit();
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> deviceBluetooths = [];
    // printerPrint(BluetoothDevice("RPP02N", "86:67:7A:FB:52:10"));
    try {
      deviceBluetooths = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }
    devices.assignAll(deviceBluetooths);
  }

  void printerPrint(BluetoothDevice? device) async {
    if (device != null) {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(device);
        }
      });
    }
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printLeftRight("23 Januari 2023", "19:00", 0);
        bluetooth.printCustom("--------------------------------", 0, 3);
        bluetooth.printCustom("*Testing Printer*", 1, 3);
        bluetooth.printCustom("--------------------------------", 0, 3);
        bluetooth.printLeftRight("Notes", "", 0);
        bluetooth.printLeftRight("Terima kasih", "", 0);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
