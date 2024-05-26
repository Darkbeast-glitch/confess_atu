import 'package:confess_atu/models/confessions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfessionNotifier extends StateNotifier<Confession> {
  ConfessionNotifier(Confession confession) : super(confession);

  void upvote() {
    state = state.copyWith(upvotes: state.upvotes + 1);
  }

  void downvote() {
    state = state.copyWith(downvotes: state.downvotes + 1);
  }
}
