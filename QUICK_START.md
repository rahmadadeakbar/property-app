# Quick Start - Chat Feature

## ⚡ Langkah Cepat (5 Menit)

### 1. Setup Firebase (Wajib - Sekali Saja)

```bash
# Install Firebase CLI
npm install -g firebase-tools
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase untuk project ini
cd /home/raatechnomedia/Project/flutter-project/propertyapp
flutterfire configure
```

Pilih/buat project Firebase, pilih platform Android.

### 2. Enable Firestore

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Pilih project Anda
3. Klik **Firestore Database** → **Create database**
4. Pilih **"Start in test mode"**
5. Lokasi: **asia-southeast2** (Jakarta)
6. Klik **Enable**

### 3. Run App

```bash
flutter run
```

### 4. Test Chat

1. Tap **Messages** icon di bottom navigation
2. Tap tombol **+** (FAB) untuk create demo chat
3. Buka chat room, kirim pesan
4. Long press chat room untuk delete

## ✅ Fitur CRUD Lengkap

| Operation | Feature | Status |
|-----------|---------|--------|
| **CREATE** | Create chat room | ✅ |
| **CREATE** | Send message | ✅ |
| **READ** | List chat rooms (real-time) | ✅ |
| **READ** | View messages (real-time) | ✅ |
| **UPDATE** | Update last message | ✅ |
| **UPDATE** | Mark as read | ✅ |
| **UPDATE** | Unread count | ✅ |
| **DELETE** | Delete chat room | ✅ |
| **DELETE** | Delete message | ✅ |

## 📁 Files Created

```
lib/
├── main.dart                 [UPDATED] Firebase init + Messages nav
├── models/
│   ├── chat_room.dart       [NEW] ChatRoom model
│   └── message.dart         [NEW] Message model
├── services/
│   └── chat_service.dart    [NEW] Firebase CRUD service
└── pages/
    └── messages_page.dart   [NEW] Chat UI (list + conversation)

pubspec.yaml                  [UPDATED] Firebase dependencies
CHAT_SETUP.md                [NEW] Full documentation
QUICK_START.md               [NEW] This file
```

## 🔧 Troubleshooting

**Error: Firebase not initialized**
→ Run `flutterfire configure`

**Error: Permission denied**
→ Set Firestore to test mode (see step 2)

**Chat tidak muncul**
→ Check internet connection, restart app

## 📚 Docs

Dokumentasi lengkap: `CHAT_SETUP.md`

## 🎯 Next: Authentication (Optional)

Saat ini menggunakan mock user ID. Untuk production:
1. Enable Firebase Authentication
2. Replace `currentUserId` dengan real Firebase Auth UID
3. Update Firestore security rules

---

**Ready to use!** 🚀
