import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;

  const ChatUser(
      {required this.id,
        required this.photoUrl,
        required this.displayName,
        required this.phoneNumber,
        required this.aboutMe});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? email,
  }) =>
      ChatUser(
          id: id ?? this.id,
          photoUrl: photoUrl ?? this.photoUrl,
          displayName: nickname ?? displayName,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          aboutMe: email ?? aboutMe);

  Map<String, dynamic> toJson() => {
    displayName: displayName,
    photoUrl: photoUrl,
    phoneNumber: phoneNumber,
    aboutMe: aboutMe,
  };
  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String aboutMe = "";

    try {
      photoUrl = snapshot.get(photoUrl);
      nickname = snapshot.get(nickname);
      phoneNumber = snapshot.get(phoneNumber);
      aboutMe = snapshot.get(aboutMe);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
        id: snapshot.id,
        photoUrl: photoUrl,
        displayName: nickname,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id, photoUrl, displayName, phoneNumber, aboutMe];
}