import 'package:get_it/get_it.dart';
import 'package:kawal_desa_dwi/services/api_service.dart';
import 'package:kawal_desa_dwi/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
}