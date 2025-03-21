import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../presentation/providers/provider.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;

  late StreamSubscription<ConnectivityResult> _subscription;

  ConnectivityService._internal();

  void startListening() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      needToShowNetworkSnackBar = true;
      if (result == ConnectivityResult.none) {
        isNetworkAvailable.value = false;
        isBackOnlineEnable = true;
      } else {
        isNetworkAvailable.value = true;
      }
    });
  }

  Future<void> checkConnectivity() async {
    await Connectivity().checkConnectivity().then((ConnectivityResult result) {
      needToShowNetworkSnackBar = true;
      if (result == ConnectivityResult.none) {
        isNetworkAvailable.value = false;
        isBackOnlineEnable = true;
      } else {
        isNetworkAvailable.value = true;
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
