import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://test.atena.id/Api/';

  Future<http.Response> postFormData({
    required String endpoint,
    Map<String, String>? data,
    Map<String, dynamic>? file,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(baseUrl + endpoint);
    final request = http.MultipartRequest('POST', uri);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (data != null) {
      request.fields.addAll(data);
    }
    final response = await request.send();
    return await http.Response.fromStream(response);
  }
}
