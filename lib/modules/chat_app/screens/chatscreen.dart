import 'package:flutter/material.dart';
import '../exports.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final String receiversEmail;
  final String receiverID;
  const ChatScreen({
    super.key,
    required this.receiversEmail,
    required this.username,
    required this.receiverID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messagecontroller = TextEditingController();

  // final Authservices _auth = Authservices();
  final Chatservices _chatservices = Chatservices();

  //send message
  void sendmessage() async {
    //if message is not empty
    if (messagecontroller.text.isNotEmpty) {
      //send message
      await _chatservices.sendmessage(
          widget.receiverID, messagecontroller.text);
      //clear message
      messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        title: Text(
          widget.username,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //message list
          Expanded(
            child: Messagelist(receiverID: widget.receiverID),
          ),
          //textfield
          _buildsendmessage(),
        ],
      ),
    );
  }

  Widget _buildsendmessage() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Commontextfield(
                hintText: "Message",
                controller: messagecontroller,
                readOnly: false,
                obscureText: false,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              // margin: EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: sendmessage,
                icon:  Icon(
                  Icons.send,
                  color:Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ));
  }
}
