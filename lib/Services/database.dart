import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDataBase {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
  CollectionReference ChatRoom =
      FirebaseFirestore.instance.collection("ChatRoom");

  CreateChatRoom(String ChatRoomId, Map ChatRoomMap) {
    ChatRoom.doc(ChatRoomId).set(ChatRoomMap).catchError((onError) {
      print("Error From Print : $onError");
    });
  }

  getUserByUsername(String Username) async {
    return await usersRef.where('Username', isEqualTo: Username).get();
  }

  getUserByUserEmail(String UserEmail) async {
    return await usersRef.where('Email', isEqualTo: UserEmail).get();
  }

  UploadUserInfo(Map UserMap) {
    instance.collection("Users").add(UserMap);
  }

  addConversationMessage(String ChatRoomId, Map MessageMap) {
    return  ChatRoom.doc(ChatRoomId).collection('Chats').add(MessageMap).catchError((onError)=> print("$onError"));
  }

  getConversationMessage(String ChatRoomId)async {
    return await ChatRoom.doc(ChatRoomId).
    collection('Chats').
    orderBy('time', descending: false).
    snapshots();
  }

  getChatRooms(String Username)async{
      return await ChatRoom.where('users', arrayContains: Username).snapshots();
  }
}
