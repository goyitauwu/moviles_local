import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsna1/models/popular_model.dart';

class ApiPopular{
  Uri link=Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=e7e098daf683f0084f0e71c1016d31b5&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async{
    var result = await http.get(link);
    var ListJSON = jsonDecode(result.body)['results'] as List;
    if(result.statusCode == 200){
      return ListJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }

    return null;
  }
}