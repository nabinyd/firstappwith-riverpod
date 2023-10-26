import 'dart:convert';

import 'package:firstapp/riverpod/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String apikey = 'https://jsonplaceholder.typicode.com/posts';
  Future<List<UserModel>> getuser() async {
    final response = await http.get(Uri.parse(apikey));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body.toString())['data'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
