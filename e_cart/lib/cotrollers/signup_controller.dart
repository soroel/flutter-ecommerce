import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpController {
  final String apiUrl = "http://192.168.11.29:8000/register";

  Future<Map<String, dynamic>> signUp(String email, String password) async {
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

      if (response.statusCode == 201) {
        // If the server did return a 201 Created response,
        // then parse the JSON.
        return {
          'status': true,
          'message': 'User registered successfully.',
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 200) {
        // Handling cases where the server returns 200 for success
        return {
          'status': true,
          'message': 'User registered successfully.',
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        // If the server did not return a 201/200 response,
        // then throw an exception with the server error message.
        return {
          'status': false,
          'message': jsonDecode(response.body)['error'] ?? 'Invalid data provided.',
        };
      } else if (response.statusCode == 409) {
        // Handle conflict, e.g., email already exists
        return {
          'status': false,
          'message': 'Email already exists. Please use a different email.',
        };
      } else {
        // Handle other status codes
        return {
          'status': false,
          'message': 'Failed to register. Server error with status code: ${response.statusCode}.',
        };
      }
    } catch (exception) {
      // For errors like no internet connection, etc.
      print('Exception: $exception'); // Debugging line
      return {
        'status': false,
        'message': 'Failed to register. Check your network connection and try again.',
      };
    }
  }
}
