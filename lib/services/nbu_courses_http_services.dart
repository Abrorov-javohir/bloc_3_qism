import 'dart:convert';
import 'package:bloc_3_qism/data/model/course.dart';
import 'package:http/http.dart' as http;

class ConvertationHttpService {
  final url = Uri.parse('https://nbu.uz/exchange-rates/json/');

  Future<List<Course>> getCurses() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => Course.fromJson(json)).toList();
      } else {
        throw Exception("Serverga ulanishga muammoga duch keldik");
      }
    } catch (e) {
      throw Exception("Xatolik: $e");
    }
  }
}