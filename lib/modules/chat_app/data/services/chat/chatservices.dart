import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../exports.dart';

class Chatservices {
  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user stream
  Stream<List<Map<String, dynamic>>> getuserstream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //got through each user
        final user = doc.data();
        //return user
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendmessage(String receiverID, String message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create message
    Message newmessage = Message(
      message: message,
      senderID: currentUserID,
      receiverID: receiverID,
      timestamp: timestamp,
      senderEmail: currentUserEmail,
    );
    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids (this ensure the chat room ID is same for both users)
    String chatroomID = ids.join('_');

    //add a new message to database
    await _firestore
        .collection('chatrooms')
        .doc(chatroomID)
        .collection('messages')
        .add(newmessage.toMap());
  }
  //get messages
  Stream<QuerySnapshot>getMessages(String userID,String otherUserID){
    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort(); //sort the ids (this ensure the chat room ID is same for both users)
    String chatroomID = ids.join('_');
    return _firestore
        .collection('chatrooms')
        .doc(chatroomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
