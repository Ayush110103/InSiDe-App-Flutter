import 'dart:convert';

// import 'package:chatgpt_flutter/api_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGPTScreen extends StatefulWidget {
  @override
  _ChatGPTScreenState createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final List<Message> _messages = [];
  static const apiKey = "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";
  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    // Create a Message object for the user's message
    Message userMessage = Message(text: _textEditingController.text, isMe: true);

    // Clear the input field
    _textEditingController.clear();

    // Add the user's message to the chat interface
    setState(() {
      _messages.insert(0, userMessage);
    });

    // Send the user's message to Chat GPT and await the response
    String response = await sendMessageToChatGpt(userMessage.text);

    // Create a Message object for the response from Chat GPT
    Message chatGptMessage = Message(text: response, isMe: false);

    // Add the response from Chat GPT to the chat interface
    setState(() {
      _messages.insert(0, chatGptMessage);
    });
  }


  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${apiKey}",
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedReponse = json.decode(response.body);
      String reply = parsedReponse['choices'][0]['message']['content'];
      return reply;
    } else {
      // Log and handle API response errors
      print("API Request Error - Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      // Handle the error gracefully, e.g., display an error message to the user.
      return "An error occurred while fetching the response from Chat GPT.";
    }
  }
  Widget _buildMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
          message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'You' : 'GPT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message.text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: onSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}