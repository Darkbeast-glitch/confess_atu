import 'package:confess_atu/models/confession_viewmodel.dart';
import 'package:confess_atu/models/confessions.dart';
import 'package:confess_atu/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../confessions/confession_cards.dart';
import '../confessions/new_confession.dart';

final confessionsProvider = StreamProvider<List<Confession>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore.getConfessionsStream();
});

class HomePageContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confessions = ref.watch(confessionsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Confessions Feed',
            style: TextStyle(fontFamily: "Product Sans Bold"),
          ),
          bottom: const TabBar(
            labelColor: Colors.deepPurple, // color of the selected tab text
            unselectedLabelColor:
                Colors.black, // color of the unselected tab text
            indicatorColor: Colors.deepPurple, // color of the tab line
            tabs: [
              Tab(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Product Sans bold",
                    color: Colors.deepPurple,
                  ), // change the font size here
                  child: Text('Newest'),
                ),
              ),
              Tab(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Product Sans bold",
                    color: Colors.deepPurple,
                  ), // change the font size here
                  child: Text(
                    'Campus',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "Product Sans bold",
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Tab(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Product Sans bold",
                    color: Colors.deepPurple,
                  ), // change the font size here
                  child: Text('Loudest'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            confessions.when(
              data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Container(
                  height: 200.0, // Set a specific height
                  child: ConfessionCard(
                    confession: data[index],
                    confessionLocator: ConfessionCardViewModel(),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text('Error: $error'),
            ),
            // TODO: Replace these with the actual content for the other tabs
            const Center(child: Text('Most Commented')),
            const Center(child: Text('Loudest')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewConfessionScreen()),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
