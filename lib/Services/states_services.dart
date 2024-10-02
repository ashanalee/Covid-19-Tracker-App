import 'dart:convert';
import 'package:covid19_app/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import '../Modal/world_state_model.dart';


class StatesServices{
  Future<WorldStateModel> fetchworkstaterecord() async{
    final response = await http.get(Uri.parse(AppUrls.worldstateapi));
    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return WorldStateModel.fromJson(data);
      }
    else
      {
        throw Exception('Error');
      }
  }

  Future<List<dynamic>> Countrieslist() async{
    final response = await http.get(Uri.parse(AppUrls.countarieslist));
    if(response.statusCode == 200)
    {
      var data = jsonDecode(response.body);
      return data;
    }
    else
    {
      throw Exception('Error');
    }
  }

}