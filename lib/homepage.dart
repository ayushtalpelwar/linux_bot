import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:linux_bot/messages.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DialogFlowtter dialogflowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogflowtter = instance);
    super.initState();
  }

  _sendMessage(String text) async {
    if (text.isEmpty) {
      return;
    } else {
      setState(() {
        _addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogflowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) {
        return;
      }
      setState(() {
        _addMessage(response.message!);
      });
    }
  }

  _addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LinuxBot',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 22, color: Colors.lightGreenAccent),
          ),
        ),
        leading: Icon(Icons.terminal_rounded,color: Colors.redAccent,size: 28,),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Help'),
                  content: Text(
                    'The Linux Helper Bot is designed to assist users in navigating and performing tasks within the Linux terminal. Whether you\'re a beginner or an experienced user, the bot is here to help with commands, tips, and general Linux-related inquiries.',
                    style: GoogleFonts.roboto(),
                    textAlign: TextAlign.justify,
                  ),
                ),
              );
            },
            icon: Icon(Icons.info_outline,color: Colors.redAccent,size: 28,),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MessagesScreen(
                messages: messages,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'user@linuxbot:  ',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 16, color: Colors.lightGreenAccent),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '...',
                        border: InputBorder.none,
                      ),
                      controller: _controller,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: Icon(Icons.send,color: Colors.redAccent,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
