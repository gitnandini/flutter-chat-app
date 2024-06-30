// import 'dart:js_interop';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/widgets/chat/message.dart';
import 'package:chat/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('FlutterChat'),
          backgroundColor: Color.fromARGB(255, 178, 96, 192),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  )),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ]),
      body:
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('chats/XqYgAELs2k4ZlTOMX9pt/messages')
          //       .snapshots(),
          //   builder: (ctx, streamSnapshot) {
          //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     final documents = streamSnapshot.data?.docs;
          //     return ListView.builder(
          //       itemCount: streamSnapshot.data?.docs.length,
          //       itemBuilder: (ctx, index) => Container(
          //         padding: EdgeInsets.all(8),
          //         child: Text(documents?[index]['text']),
          //       ),
          //     );
          //   },
          // ),
          Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
