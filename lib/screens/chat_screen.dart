import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chats/xPF7trtQlVyMdsV8EIs7/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            //just add this line
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = streamSnapshot.data.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(docs[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/xPF7trtQlVyMdsV8EIs7/messages')
              .add({'text': 'This was added by clicking the button'});
        },
      ),
    );
  }
}
