
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/app_user.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements AuthService {
  static AppUser? _currentUser;

  static final _userStream = Stream<AppUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toAppUser(user);
      controller.add(_currentUser);
    }
  });

  AppUser? get currentUser {
    return _currentUser;
  }

  Stream<AppUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      final imageName = '${credential.user!.uid}.jpg';
      final imageURL = await _uploadUserImage(image, imageName);

      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(imageURL);

      await login(email, password);

      _currentUser = _toAppUser(credential.user!, name, imageURL);
      await _saveAppUser(_currentUser!);
    }

    await signup.delete();
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveAppUser(AppUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
    });
  }

  static AppUser _toAppUser(User user, [String? name, String? imageURL]) {
    return AppUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
