import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

class GeminiService {
  static const String apiKey = 'API_KEY';
  static const String url = 'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey';

  static Future<void> fetchRiskAndRemedy(String cropName) async {
    final prompt = '''
Give me 100 words of risk and 100 words of remedy for the crop: $cropName
Respond in the format:
RISK: ...
REMEDY: ...
''';

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [{"text": prompt}]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final content = json.decode(response.body);
      final output = content['candidates'][0]['content']['parts'][0]['text'];

      // Updated regex to correctly separate risk and remedy
      final riskMatch = RegExp(r'RISK:\s*(.*?)\s*REMEDY:', dotAll: true).firstMatch(output);
      final remedyMatch = RegExp(r'REMEDY:\s*(.*)', dotAll: true).firstMatch(output);

      riskText = riskMatch?.group(1)?.trim() ?? 'No risk found.';
      remedyText = remedyMatch?.group(1)?.trim() ?? 'No remedy found.';

      print("✅ Risk: $riskText\n✅ Remedy: $remedyText");
    } else {
      riskText = 'Error fetching risk.';
      remedyText = 'Error fetching remedy.';
      print("❌ API Error: ${response.statusCode} - ${response.body}");
    }
  }
}
