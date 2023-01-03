import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sars2/Model/total_model.dart';
import 'package:sars2/Utility/app_url.dart';

class WorldStatesViewModel {
  Future<TotalModel> fetchWorldRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return TotalModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
  Future<List<dynamic>>fetchCountryRecords() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
     var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
