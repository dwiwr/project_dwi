import 'package:kawal_desa_dwi/constants/router_name.dart';
import 'package:kawal_desa_dwi/services/navigation_service.dart';
import 'package:kawal_desa_dwi/viewmodels/base_model.dart';
import '../locator.dart';

class LoginViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToSignUpView(){
    _navigationService.navigateTo(SignUpViewRoute);
  }

  get emailController => null;

  get passwordController => null;

}