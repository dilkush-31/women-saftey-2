import 'dart:convert';
import 'package:http/http.dart' as http;

var client = http.Client();

Future<void> sendEmailViaBackend(String to, String message) async {
  final response = await client.post(
    Uri.parse("https://empower-email-svc.ombaji124-d31.workers.dev/send-email"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'to': to, 'message': message, 'subject' : "SOS Alert (Empower Me!)"}),
  );

  if (response.statusCode == 200) {
    print("SMS sent successfully");
  } else {
    print("Failed to send SMS: ${response.body}");
  }
}
