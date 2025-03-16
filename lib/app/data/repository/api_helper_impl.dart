import 'dart:convert';

import 'api_helper.dart';
import 'package:http/http.dart' as http;

class ApiHelperImpl implements ApiHelper {
  @override
  Future<Map<String, dynamic>> getUID({required String link}) async {
    final url = 'https://id.traodoisub.com/api.php';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'accept': 'application/json, text/javascript, */*; q=0.01',
      },
      body: 'link=${Uri.encodeComponent(link)}',
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return jsonResponse;
    } else {
      throw Exception('Get UID thất bại');
    }
  }
}
