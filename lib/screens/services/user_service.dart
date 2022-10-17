import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

enum StateRegistration {
  COMPLETE,
  IN_PROGRESS,
}

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<UserModel> get user {
    return _auth.authStateChanges().asyncMap((user) => UserModel(
          uid: user!.uid,
          email: user.email,
        ));
  }

  Future<UserModel> auth(UserModel userModel) async {
    UserCredential userCredential;

    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );
    } catch (e) {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );
      await mailingList(
        userModel.email,
        stateRegistration: StateRegistration.COMPLETE,
      );
    }

    userModel.setUid = userCredential.user!.uid;

    return userModel;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<StateRegistration> mailingList(
    String? email, {
    StateRegistration? stateRegistration,
  }) async {
    String collection = "mailingList";

    DocumentReference documentReference =
        _firebaseFirestore.collection(collection).doc(email);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (stateRegistration != null) {
      await _firebaseFirestore.collection(collection).doc(email).set({
        "state": stateRegistration.toString(),
      });

      return stateRegistration;
    }

    if (documentSnapshot.exists) {
      String state = documentSnapshot.get("state");

      return StateRegistration.values
          .firstWhere((element) => element.toString() == state);
    }

    await documentReference
        .set({"state": StateRegistration.IN_PROGRESS.toString()});

    return StateRegistration.IN_PROGRESS;
  }
}
