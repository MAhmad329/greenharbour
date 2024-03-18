import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:green_harbour/models/user_model.dart';

class AuthServiceProvider with ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  User? get currentUser => _currentUser;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().asyncMap(_fetchUserData);
  }

  Future<User?> _fetchUserData(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      return null;
    }

    var snapshot =
        await _firestore.collection('users').doc(firebaseUser.uid).get();
    var userData = snapshot.data();
    String name = userData?['name'] ?? '';

    _currentUser =
        User(firebaseUser.uid, firebaseUser.email, firebaseUser.displayName);

    return _currentUser;
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final firebaseUser = credential.user;

      if (firebaseUser != null) {
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'email': firebaseUser.email,
          'name': name,
        });

        return _fetchUserData(firebaseUser);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _fetchUserData(credential.user);
    } catch (e) {
      print(e);
    }
    return null;
  }

  // Future<void> updateUserInterest(String userId, String interest) async {
  //   await _firestore.collection('users').doc(userId).update({
  //     'selectedInterest': interest,
  //   });
  //
  //   if (_currentUser != null) {
  //     _currentUser!.selectedInterest = interest;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> updateUserLevel(String level) async {
  //   if (_currentUser != null) {
  //     await _firestore.collection('users').doc(_currentUser!.uid).update({
  //       'level': level,
  //     });
  //   }
  // }
  //
  // Future<void> completeSetup(String userId) async {
  //   await _firestore.collection('users').doc(userId).update({
  //     'hasCompletedSetup': true,
  //   });
  //
  //   if (_currentUser != null) {
  //     _currentUser!.hasCompletedSetup = true;
  //     notifyListeners();
  //   }
  // }

  Future<void> changePassword(String newPassword) async {
    auth.User? firebaseUser = _firebaseAuth.currentUser;
    try {
      await firebaseUser?.updatePassword(newPassword);
      // Handle success
    } on auth.FirebaseAuthException catch (e) {
      // Handle errors, e.g., password too weak
      print(e);
    }
  }

  Future<String?> getUserName() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    return userDoc.data()?['name'];
  }

  Future<void> updateUserName(String userId, String newName) async {
    // Update the user's name in Firebase
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'name': newName});
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
