import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:kawal_desa_dwi/services/navigation_service.dart';
import 'package:kawal_desa_dwi/viewmodels/base_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../locator.dart';

class CameraViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;
  String data = "";

  void initModel(bool mounted){

  }

  void getAvailabeCamera(bool mounted){
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0){
        selectedCameraIdx = 1;
        setBusy(false);
      } else {
        print("camera not available");
      }
    }).catchError((err){
      print("Errpr: $err.code\nError Message: $err.message");
    });
      setBusy(false);
  }

  Future _initCameraController(
      CameraDescription cameraDescription, bool mounted) async{
    if (controller != null){
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.max);

    controller.addListener(() {
      if (mounted) {
        setBusy(false);
      }
      if (controller.value.hasError){
        print("Camera error ${controller.value.errorDescription}");
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showCameraException(e);
    }

    if (mounted){
      setBusy(false);

    }
  }

  void showCameraException(CameraException e){
    String errorText = "error: ${e.code}\nError message: ${e.description}";
  }

  void onCapturePressed(context) async {
    try{
      final directory = await getExternalStorageDirectories();
      final dateFormat = formatDate;
      final fileName = "${dateFormat.toString()}-PPTIK.png";

      final path = join(
          (await getTemporaryDirectory()).path, "${dateFormat.toString()}-PPTIK.png");
      await controller.takePicture();
      _navigationService.popUpWithValue('$path#$fileName');
    }  catch (e){
      print(e);
    }
  }

  void onSwitchedCamera(bool mounted){
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1: 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera, mounted);
  }

  String formatDate(){
    DateFormat dateFormat = DateFormat("MM_dd_yyyy_HH_mm_ss");
    return dateFormat.format(DateTime.now());
}

}