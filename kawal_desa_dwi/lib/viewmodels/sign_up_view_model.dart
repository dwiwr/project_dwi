import 'package:kawal_desa_dwi/constants/router_name.dart';
import 'package:kawal_desa_dwi/services/api_service.dart';
import 'package:kawal_desa_dwi/services/navigation_service.dart';
import 'package:kawal_desa_dwi/viewmodels/base_model.dart';
import '../locator.dart';

class SignUpViewModel extends BaseModel {
  String unitSelected;
  String company;
  String imagePath = "";
  String imagePathKk = "";
  String imagePathProfile = "";
  List<String> units = List();

  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();


  void onUnitChangeSelect(String value){
    unitSelected = value;
    setBusy(false);
  }

  bool changeVisibility() {
    if (units == null || units.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  void getCompanyUnit(String code) async {
    setBusy(false);
    units.clear();
    unitSelected = null;
    final unit = await _apiService.getCompanyUnit(code);
    if (unit != null) {
      unit.data.forEach((value) { units.add(value);
      });
    }
    setBusy(false);
  }

  Future<void> cameraView(String type) async {
    setBusy(true);
    final path = await _navigationService.navigateTo(CameraViewRoute);
    if (type == "KTP"){
      imagePath = path.toString().split('#')[0];
    } else if (type == "KK") {
      imagePathKk = path.toString().split('#')[0];
    } else if (type == "Profile") {
      imagePathProfile = path.toString().split('#')[0];
    }
  }

  bool isPathNull(String type){
    if (type == "KTP"){
      if(imagePath == null || imagePath.isEmpty){
        return false;
      } else if (type == "KK" || imagePathKk.isEmpty){
        return false;
      } else if (type == "Profile" || imagePathProfile.isEmpty){
        return false;
      }
    }
    return true;
  }


}