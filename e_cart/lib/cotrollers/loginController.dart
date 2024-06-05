import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginController {
  final String apiUrl = "http://192.168.1.10:8000/login";

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      return _handleResponse(response);
    } catch (exception) {
      // Handle network or other errors
      return {
        'status': false,
        'error': 'Failed to login. Check your network connection and try again.'
      };
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      // Login successful
        return responseBody;
      case 400:
      case 401:
      // Client error, likely incorrect login credentials
        return {
          'status': false,
          'error': responseBody['error'] ?? 'Invalid login credentials.'
        };
      default:
      // Other errors
        return {
          'status': false,
          'error': 'Server encountered an unexpected condition which prevented it from fulfilling the request.'
        };
    }
  }
}
