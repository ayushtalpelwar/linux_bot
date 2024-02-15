import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.messages});
  final List messages;
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.messages[index]['isUserMessage']
                        ? 'user@linuxbot: '
                        : '>>>> ',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: widget.messages[index]['isUserMessage']
                            ? Colors.lightGreenAccent
                            : Colors.redAccent,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: widget.messages[index]['isUserMessage']
                            ? w - 150
                            : w - 80),
                    child: Text(
                      widget.messages[index]['message'].text.text[0],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (_, i) {
        return Padding(padding: EdgeInsets.only(top: 1));
      },
    );
  }
}
