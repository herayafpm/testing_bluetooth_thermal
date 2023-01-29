import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:testing_bluetooth_thermal/controllers/print_controller.dart';

class PrintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Bluetooth Thermal"),
      ),
      body: PrintView(),
    );
  }
}

class PrintView extends StatelessWidget {
  final controller = Get.put(PrintController());
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    controller.initPlatformState();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            flex: 1,
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onRefresh: _onRefresh,
              onLoading: null,
              child: Obx(() {
                if (controller.devices.length > 0) {
                  return ListView.builder(
                    itemCount: controller.devices.length,
                    itemBuilder: (BuildContext context, int index) {
                      BluetoothDevice device = controller.devices[index];
                      return ListTile(
                        onTap: () {
                          controller.printerPrint(device);
                        },
                        title: Text(device.name!),
                        subtitle: Text(device.address!),
                        leading: Icon(Icons.print),
                        tileColor: Colors.white,
                      );
                    },
                  );
                }
                return Parent(
                  style: ParentStyle()
                    ..ripple(true, splashColor: Colors.blueAccent)
                    ..width(Get.width),
                  gesture: Gestures()
                    ..onTap(() {
                      controller.initPlatformState();
                    }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      Txt(
                        "Printer tidak ditemukan",
                        style: TxtStyle()..textColor(Colors.white),
                      ),
                    ],
                  ),
                );
              }),
            )),
      ],
    );
    ;
  }
}
