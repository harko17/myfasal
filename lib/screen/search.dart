import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIPage extends StatefulWidget {
  @override
  _AIPageState createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  final String apiKey = '42844f5ebdcf4916b47b6b521b0df5db';  // Replace with your actual API key
  final String baseURL = 'https://api.aimlapi.com';
  final String systemPrompt = 'You are a travel agent. Be descriptive and helpful';
  final String userPrompt = 'Tell me about San Francisco';
  String _response = '';
  bool _isLoading = false;

  Future<void> _getAIResponse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('$baseURL/chat/completions');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

      final body = jsonEncode({
        'model': 'mistralai/Mistral-7B-Instruct-v0.2',
        'messages': [
          {
            'role': 'system',
            'content': systemPrompt,
          },
          {
            'role': 'user',
            'content': userPrompt,
          },
        ],
        'temperature': 0.7,
        'max_tokens': 256,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiResponse = data['choices'][0]['message']['content'];

        setState(() {
          _response = aiResponse;
        });
      } else {
        setState(() {
          _response = 'Error: Unable to fetch response';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Travel Agent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('User: $userPrompt'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getAIResponse,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Get AI Response'),
            ),
            SizedBox(height: 24.0),
            Text(
              'AI Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response.isEmpty ? 'No response yet' : _response,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
