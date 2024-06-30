import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/widgets/chat/new_message.dart';
import 'package:chat/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Future.value(FirebaseAuth.instance.currentUser),
      // future: FirebaseAuth.instance.currentUser!,
      builder: (ctx, futureSnapshot) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                return Center(child: Text('No messages yet.'));
              }
              final chatDocs = chatSnapshot.data!.docs;

              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['username'],
                  chatDocs[index]['userId'] == futureSnapshot.data?.uid,

                  //documentID is depricaed use id instaed
                  key: ValueKey(chatDocs[index].id),
                ),
              );
            });
      },
    );
  }
}
