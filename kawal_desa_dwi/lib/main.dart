import 'package:flutter/material.dart';
import 'package:kawal_desa_dwi/services/navigation_service.dart';
import 'package:kawal_desa_dwi/ui/router.dart';
import 'package:kawal_desa_dwi/ui/views/login_view.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginView(),
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigationKey,
    );
  }
}
