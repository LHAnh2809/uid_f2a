import 'dart:io';

abstract class ApiHelper {
  Future<Map<String, dynamic>> getUID({required String link});
}
