import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final String propertyId;
  final String propertyTitle;
  final String propertyImage;
  final String buyerId;
  final String buyerName;
  final String sellerId;
  final String sellerName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatRoom({
    required this.id,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyImage,
    required this.buyerId,
    required this.buyerName,
    required this.sellerId,
    required this.sellerName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  // Convert Firestore document to ChatRoom object
  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
      id: doc.id,
      propertyId: data['propertyId'] ?? '',
      propertyTitle: data['propertyTitle'] ?? '',
      propertyImage: data['propertyImage'] ?? '',
      buyerId: data['buyerId'] ?? '',
      buyerName: data['buyerName'] ?? '',
      sellerId: data['sellerId'] ?? '',
      sellerName: data['sellerName'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: (data['lastMessageTime'] as Timestamp).toDate(),
      unreadCount: data['unreadCount'] ?? 0,
    );
  }

  // Convert ChatRoom object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'propertyImage': propertyImage,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'unreadCount': unreadCount,
    };
  }
}
