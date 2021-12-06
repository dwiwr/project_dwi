import 'package:http/http.dart' as http;
import 'package:kawal_desa_dwi/constants/const.dart';
import 'package:path/path.dart' as path;
import 'package:kawal_desa_dwi/models/company_unit_data.dart';

class ApiService{
  Future<CompanyUnitData> getCompanyUnit(String companyCode) async{
    final client= http.Client();
    try {
      final reportUrl= '${BASE_URL}company/$companyCode/units?code=true';
      final response= await client.get(reportUrl);
      final companyUnitData= companyUnitDataFormJson(response.body);
      if (companyUnitData.code != 200) {
        return null;
      }
      return companyUnitData;
    } catch (e) {
      return null;
    }
  }
}