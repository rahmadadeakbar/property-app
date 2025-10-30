import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_room.dart';
import '../models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CRUD Operations for Chat Rooms

  // Create a new chat room
  Future<String> createChatRoom(ChatRoom chatRoom) async {
    try {
      DocumentReference docRef = await _firestore
          .collection('chatRooms')
          .add(chatRoom.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create chat room: $e');
    }
  }

  // Read: Get all chat rooms for a user (real-time stream)
  Stream<List<ChatRoom>> getChatRooms(String userId) {
    return _firestore
        .collection('chatRooms')
        .where('buyerId', isEqualTo: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ChatRoom.fromFirestore(doc)).toList(),
        );
  }

  // Read: Get a specific chat room
  Future<ChatRoom?> getChatRoom(String chatRoomId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .get();
      if (doc.exists) {
        return ChatRoom.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get chat room: $e');
    }
  }

  // Update: Update chat room (last message, unread count)
  Future<void> updateChatRoom(
    String chatRoomId,
    String lastMessage,
    DateTime lastMessageTime,
  ) async {
    try {
      await _firestore.collection('chatRooms').doc(chatRoomId).update({
        'lastMessage': lastMessage,
        'lastMessageTime': Timestamp.fromDate(lastMessageTime),
        'unreadCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to update chat room: $e');
    }
  }

  // Delete: Delete a chat room and all its messages
  Future<void> deleteChatRoom(String chatRoomId) async {
    try {
      // Delete all messages in the chat room
      QuerySnapshot messages = await _firestore
          .collection('messages')
          .where('chatRoomId', isEqualTo: chatRoomId)
          .get();

      for (DocumentSnapshot doc in messages.docs) {
        await doc.reference.delete();
      }

      // Delete the chat room
      await _firestore.collection('chatRooms').doc(chatRoomId).delete();
    } catch (e) {
      throw Exception('Failed to delete chat room: $e');
    }
  }

  // CRUD Operations for Messages

  // Create: Send a new message
  Future<void> sendMessage(Message message) async {
    try {
      // Add message to messages collection
      await _firestore.collection('messages').add(message.toFirestore());

      // Update chat room with last message
      await updateChatRoom(message.chatRoomId, message.text, message.timestamp);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Read: Get messages for a chat room (real-time stream)
  Stream<List<Message>> getMessages(String chatRoomId) {
    return _firestore
        .collection('messages')
        .where('chatRoomId', isEqualTo: chatRoomId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList(),
        );
  }

  // Update: Mark message as read
  Future<void> markMessageAsRead(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).update({
        'isRead': true,
      });
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  // Update: Mark all messages in a chat room as read
  Future<void> markAllMessagesAsRead(String chatRoomId, String userId) async {
    try {
      QuerySnapshot messages = await _firestore
          .collection('messages')
          .where('chatRoomId', isEqualTo: chatRoomId)
          .where('senderId', isNotEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      for (DocumentSnapshot doc in messages.docs) {
        await doc.reference.update({'isRead': true});
      }

      // Reset unread count in chat room
      await _firestore.collection('chatRooms').doc(chatRoomId).update({
        'unreadCount': 0,
      });
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  // Delete: Delete a specific message
  Future<void> deleteMessage(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).delete();
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  // Search: Search messages in a chat room
  Future<List<Message>> searchMessages(String chatRoomId, String query) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('messages')
          .where('chatRoomId', isEqualTo: chatRoomId)
          .orderBy('timestamp', descending: true)
          .get();

      List<Message> messages = snapshot.docs
          .map((doc) => Message.fromFirestore(doc))
          .toList();

      // Filter messages by text content
      return messages
          .where((msg) => msg.text.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search messages: $e');
    }
  }
}
