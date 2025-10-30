# Chat Feature - Firebase Setup Instructions

## Fitur yang Sudah Dibuat

✅ **CRUD Operations Complete:**
- **Create**: Buat chat room baru, kirim pesan baru
- **Read**: Lihat daftar chat rooms, baca messages (real-time stream)
- **Update**: Update last message, mark messages as read, update unread count
- **Delete**: Hapus chat room dan semua pesannya, hapus pesan individual

✅ **Real-time Messaging:**
- StreamBuilder untuk chat list dan messages
- Auto-scroll ke pesan terbaru
- Unread message count dengan badge merah
- Read receipts (double check marks)

✅ **UI Modern:**
- Chat list dengan preview pesan terakhir
- Bubble chat style (kiri/kanan)
- Timestamp formatting (HH:mm, Yesterday, day name, date)
- Empty state screens
- Loading indicators

## Setup Firebase (Wajib!)

Aplikasi ini menggunakan **Firebase Firestore** untuk database real-time. Ikuti langkah ini:

### 1. Install Firebase CLI

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login ke Firebase
firebase login
```

### 2. Buat Project di Firebase Console

1. Buka https://console.firebase.google.com/
2. Klik "Add project" atau "Create a project"
3. Beri nama: **propertyapp** (atau nama lain)
4. Enable Google Analytics (opsional)
5. Klik "Create project"

### 3. Setup FlutterFire

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Pastikan berada di root project
cd /home/raatechnomedia/Project/flutter-project/propertyapp

# Konfigurasi Firebase untuk Flutter
flutterfire configure
```

Saat menjalankan `flutterfire configure`:
- Pilih project Firebase yang sudah dibuat
- Pilih platforms: **Android**, **iOS** (jika perlu), **Web** (jika perlu)
- File `firebase_options.dart` akan otomatis dibuat di `lib/`

### 4. Enable Firestore Database

1. Di Firebase Console, buka project Anda
2. Klik **"Firestore Database"** di sidebar
3. Klik **"Create database"**
4. Pilih **"Start in test mode"** (untuk development)
5. Pilih lokasi: **asia-southeast2** (Jakarta) atau yang terdekat
6. Klik "Enable"

**⚠️ Security Rules (Test Mode) - Untuk Development:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2025, 12, 31);
    }
  }
}
```

**🔒 Production Security Rules (Nanti):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /chatRooms/{chatRoomId} {
      allow read: if request.auth != null && 
        (resource.data.buyerId == request.auth.uid || 
         resource.data.sellerId == request.auth.uid);
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        (resource.data.buyerId == request.auth.uid || 
         resource.data.sellerId == request.auth.uid);
    }
    
    match /messages/{messageId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        resource.data.senderId == request.auth.uid;
    }
  }
}
```

### 5. Install Dependencies

```bash
# Install packages
flutter pub get
```

### 6. Update Android Configuration

Edit `android/app/build.gradle`, pastikan minSdkVersion >= 21:

```gradle
android {
    defaultConfig {
        minSdkVersion 21  // Minimal untuk Firebase
        targetSdkVersion 34
    }
}
```

### 7. Run Application

```bash
# Debug mode
flutter run

# Release APK
flutter build apk --release
```

## Testing Chat Feature

### Buat Chat Room Demo

1. Buka aplikasi
2. Tap icon "Messages" di bottom navigation (icon chat bubble)
3. Tap tombol floating action button (FAB) dengan icon "+"
4. Chat room demo akan dibuat otomatis

### Test CRUD Operations

**CREATE:**
- Tap FAB di Messages page untuk buat chat room baru
- Kirim pesan di chat room

**READ:**
- Lihat daftar chat rooms di Messages page (real-time)
- Buka chat room untuk lihat messages (real-time)

**UPDATE:**
- Pesan otomatis ter-update ketika dikirim
- Mark as read ketika buka chat room
- Unread count badge berkurang

**DELETE:**
- Long press pada chat room card
- Pilih "Delete Chat"
- Chat room dan semua messages akan terhapus

## Database Structure (Firestore)

### Collection: `chatRooms`

```
chatRooms/
  {chatRoomId}/
    - propertyId: string
    - propertyTitle: string
    - propertyImage: string
    - buyerId: string
    - buyerName: string
    - sellerId: string
    - sellerName: string
    - lastMessage: string
    - lastMessageTime: timestamp
    - unreadCount: number
```

### Collection: `messages`

```
messages/
  {messageId}/
    - chatRoomId: string
    - senderId: string
    - senderName: string
    - text: string
    - timestamp: timestamp
    - isRead: boolean
```

## API Reference (ChatService)

### Chat Room Operations

```dart
// Create
Future<String> createChatRoom(ChatRoom chatRoom)

// Read
Stream<List<ChatRoom>> getChatRooms(String userId)
Future<ChatRoom?> getChatRoom(String chatRoomId)

// Update
Future<void> updateChatRoom(String chatRoomId, String lastMessage, DateTime lastMessageTime)

// Delete
Future<void> deleteChatRoom(String chatRoomId)
```

### Message Operations

```dart
// Create
Future<void> sendMessage(Message message)

// Read
Stream<List<Message>> getMessages(String chatRoomId)
Future<List<Message>> searchMessages(String chatRoomId, String query)

// Update
Future<void> markMessageAsRead(String messageId)
Future<void> markAllMessagesAsRead(String chatRoomId, String userId)

// Delete
Future<void> deleteMessage(String messageId)
```

## Troubleshooting

### Error: "Firebase has not been initialized"

**Solusi:**
- Pastikan sudah run `flutterfire configure`
- Check file `lib/firebase_options.dart` sudah ada
- Restart aplikasi

### Error: "Missing permissions"

**Solusi:**
- Check `android/app/src/main/AndroidManifest.xml` sudah ada:
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />
  ```

### Error: "Firestore permission denied"

**Solusi:**
- Di Firebase Console → Firestore → Rules
- Pastikan rules dalam "test mode" atau sesuai user auth

### Chat tidak real-time / tidak update otomatis

**Solusi:**
- Check internet connection
- Pastikan menggunakan `StreamBuilder` bukan `FutureBuilder`
- Check Firestore rules allow read access

## Next Steps (Opsional)

1. **Add Authentication:**
   - Implement Firebase Auth (Email/Password, Google Sign-In)
   - Ganti `currentUserId` dengan real user ID dari auth

2. **Add Features:**
   - Image/photo sharing dalam chat
   - Voice messages
   - Push notifications untuk pesan baru
   - Typing indicators
   - Message reactions (emoji)

3. **Optimize:**
   - Pagination untuk message history
   - Cache messages locally
   - Compress images sebelum upload

4. **UI Enhancements:**
   - Dark mode support
   - Custom chat themes
   - Message search UI
   - Chat room settings

## File Structure

```
lib/
├── main.dart                    # Entry point dengan Firebase init
├── models/
│   ├── chat_room.dart          # ChatRoom model
│   ├── message.dart            # Message model
│   └── property.dart           # Existing property model
├── services/
│   └── chat_service.dart       # Firebase CRUD operations
└── pages/
    ├── messages_page.dart      # Chat list & conversation UI
    ├── listings_page.dart      # Existing
    ├── profile_page.dart       # Existing
    └── property_detail_page.dart # Existing
```

## Support

Jika ada error atau pertanyaan, cek:
1. Firebase Console → Firestore → Data (lihat struktur data)
2. Flutter console logs (`flutter run -v`)
3. Android Logcat untuk Android-specific issues

---

**Status:** ✅ Ready for Testing (setelah Firebase setup)
**Database:** Firebase Firestore (Real-time NoSQL)
**Features:** Complete CRUD + Real-time Streaming
