import 'dart:convert';
import 'package:http/http.dart' as http;

var client = http.Client();

Future<void> sendSmsViaBackend(String to, String message) async {
  final response = await client.post(
    Uri.parse("http://localhost:3000/send-sms"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'to': to, 'message': message}),
  );

  if (response.statusCode == 200) {
    print("SMS sent successfully");
  } else {
    print("Failed to send SMS: ${response.body}");
  }
}
