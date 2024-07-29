import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../exports.dart';

class Messagelist extends StatelessWidget {
  final String receiverID;
  const Messagelist({super.key, required this.receiverID});

  @override
  Widget build(BuildContext context) {
    final Chatservices chatservice = Chatservices();
    final Authservices authservices = Authservices();
    String senderID = authservices.getcurrentUser()!.uid;
    return StreamBuilder(
        stream: chatservice.getMessages(senderID, receiverID),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          //loading..
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //return message list
          else {
            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageListItem(doc))
                  .toList(),
            );
          }
        });
  }

  Widget _buildMessageListItem(DocumentSnapshot doc) {
    final Authservices authservices = Authservices();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderID'] == authservices.getcurrentUser()!.uid;

    //align message
    // ignore: unused_local_variable
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(
          message: data['message'],
          isCurrentUser: isCurrentUser,
        ),
      ],
    );
  }
}
