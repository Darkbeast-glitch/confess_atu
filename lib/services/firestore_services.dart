import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confess_atu/models/confessions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<Confession>> getConfessionsStream() {
    return _firestore
        .collection('confessions')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Confession.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> postConfession(Confession confession) {
    return _firestore.collection('confessions').add({
      'content': confession.content,
      'username': confession.username,
      'upvotes': confession.upvotes,
      'downvotes': confession.downvotes,
      'timestamp': Timestamp.fromDate(confession.timestamp),
      'isAnonymous': confession.isAnonymous,
      'color': confession.color.value,
      'creatorId': confession.creatorId, // new field
    });
  }

  Future<void> upvoteConfession(String confessionId) {
    return _firestore.collection('confessions').doc(confessionId).update({
      'votes': FieldValue.increment(1),
    });
  }

  Future<void> downvoteConfession(String confessionId) {
    return _firestore.collection('confessions').doc(confessionId).update({
      'votes': FieldValue.increment(-1),
    });
  }

  Future<void> deleteConfession(String confessionId) {
    return _firestore.collection('confessions').doc(confessionId).delete();
  }
}

// method to delete confesson

