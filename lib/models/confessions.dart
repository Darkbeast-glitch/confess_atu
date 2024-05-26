import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Confession {
  final String id;
  final String content;
  final String username;
  final int upvotes;
  final int downvotes;
  final DateTime timestamp;
  final bool isAnonymous;
  final Color color;
  final bool isCreator; // existing field
  final String creatorId; // new field

  Confession({
    required this.id,
    required this.content,
    required this.username,
    required this.upvotes,
    required this.downvotes,
    required this.timestamp,
    required this.isAnonymous,
    required this.color,
    this.isCreator = false, // existing field
    required this.creatorId, // new field
  });

  Confession copyWith({
    String? id,
    String? content,
    String? username,
    int? upvotes,
    int? downvotes,
    DateTime? timestamp,
    bool? isAnonymous,
    Color? color,
    bool? isCreator, // existing field
    String? creatorId, // new field
  }) {
    return Confession(
      id: id ?? this.id,
      content: content ?? this.content,
      username: username ?? this.username,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      timestamp: timestamp ?? this.timestamp,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      color: color ?? this.color,
      isCreator: isCreator ?? this.isCreator, // existing field
      creatorId: creatorId ?? this.creatorId, // new field
    );
  }

  factory Confession.fromMap(Map<String, dynamic> data, String documentId) {
    final content = data['content'] as String;
    final username = data['username'] as String;
    final upvotes = data['upvotes'] as int;
    final downvotes = data['downvotes'] as int;
    final timestamp = (data['timestamp'] as Timestamp).toDate();
    final isAnonymous = data['isAnonymous'] as bool;
    final color =
        data['color'] != null ? Color(data['color'] as int) : Colors.limeAccent;
    final isCreator =
        data['isCreator'] as bool? ?? false; // provide default value when null
    final creatorId = data['creatorId'] as String; // new line

    return Confession(
      id: documentId,
      content: content,
      username: username,
      upvotes: upvotes,
      downvotes: downvotes,
      timestamp: timestamp,
      isAnonymous: isAnonymous,
      color: color,
      isCreator: isCreator, // existing field
      creatorId: creatorId, // new field
    );
  }
}
