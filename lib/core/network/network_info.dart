//import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => checkConnection();

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    // switch
    switch (connectivityResult) {
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        return true;
      default:
        return false;
    }
  }
}
