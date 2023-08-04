import 'package:flutter/cupertino.dart';
import '../../modules/add_property_screen/add_property_screen.dart';
import '../../modules/login_screen/login_screen.dart';

abstract class AppRouter {
  static final router = <String, WidgetBuilder>{
    LoginView.route: (context) => const LoginView(),
    AddPropertyView.route: (context) => const AddPropertyView(),
    // RegisterView.route: (context) => const RegisterView(),
    // GoogleMapView.route: (context) => const GoogleMapView(),
  };
}
