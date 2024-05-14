import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../Colors/Hex_Color.dart';
import '../CustomWidgets/System_device_tile.dart';
import '../CustomWidgets/scan_result_tile.dart';
import '../utils/snackbar.dart';
import '../utils/extra.dart';
import 'devicedetail_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;

      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
          success: false);
    }
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
          success: false);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
          success: false);
    }
  }

  void onConnectPressed(BluetoothDevice device) {
    device.connectAndUpdateStream().catchError((e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e),
          success: false);
    });
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => DeviceDetailScreen(device:device),
        settings: RouteSettings(name: '/DeviceDetailScreen'));
    Navigator.of(context).push(route);
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(Duration(milliseconds: 500));
  }



  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return Padding(
        padding: const EdgeInsets.all(11),
        child: IconButton(
          color: Colors.red,
          tooltip: "Stop",
          icon: const Icon(
            Icons.stop,
            size: 30,
          ),
          onPressed: onStopPressed,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(11),
        child: TextButton(
            child: Text("Refresh",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.apply(color: HexColor("#039597"))),
            onPressed: onScanPressed),
      );
    }
  }

  List<Widget> _buildSystemDeviceTiles(BuildContext context) {
    return _systemDevices
        .map(
          (d) => SystemDeviceTile(
        device: d,
        onOpen: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DeviceDetailScreen(device: d),
            settings: RouteSettings(name: '/DeviceDetailScreen'),
          ),
        ),
        onConnect: () => onConnectPressed(d),
      ),
    )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .where((e) => e.device.platformName.startsWith('K-'))
        .map(
          (r) => ScanResultTile(
        result: r,
        onTap: () => onConnectPressed(r.device),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text("Scan Devices",
                    style: Theme.of(context).textTheme.displayLarge)),

            backgroundColor: HexColor("#2D2F38"),
            foregroundColor: Colors.white,

          ),
          backgroundColor: Colors.black,
          body: ScaffoldMessenger(
            key: Snackbar.snackBarKeyB,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Available Devices",
                    style: Theme.of(context).textTheme.displayMedium),
                backgroundColor: HexColor("#272931"),
                foregroundColor: Colors.white,
                actions: [buildScanButton(context)],
              ),
              body: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ..._buildSystemDeviceTiles(context),
                    ..._buildScanResultTiles(context),
                  ],
                ),
              ),
            ),
          ))
    ]);
  }
}
