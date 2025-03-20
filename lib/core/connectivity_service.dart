import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;

  late StreamSubscription<ConnectivityResult> _subscription;

  ConnectivityService._internal();

  bool connectivityCheck = false;

  void startListening(BuildContext context) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        context.push('/favouriteScreen');
        connectivityCheck = false;
      } else {
        if (context.canPop()) {
          // Check if current path is '/favouriteScreen' additiona req.
          context.pop();
        }
        connectivityCheck = true;
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
