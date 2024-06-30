import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.userName, this.isMe,
      {required this.key});
  final Key key;
  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                //color: Theme.of(context).primaryColorDark,
                color:
                    isMe ? Colors.grey[700] : Color.fromARGB(255, 178, 96, 192),
                borderRadius: BorderRadius.only(
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),

              //gives space between the messages
              margin: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(message,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: isMe ? TextAlign.end : TextAlign.start),
                  ])),
        ]);
  }
}
