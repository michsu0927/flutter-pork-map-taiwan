import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetJsonMapMark {
  String url = 'https://kiang.github.io/taiwanpork/data.json';
  String jsonMarks;
  List markList;
  GetJsonMapMark() {
    //this.setMarkList();
  }
  Future<String> getJson() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Json');
    }
  }

  Future<List> getMarkList() async {
    final j = await this.getJson();
    List<dynamic> l = json.decode(j);
    return l;
  }
}