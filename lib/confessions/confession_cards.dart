import 'package:confess_atu/models/confessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:permission_handler/permission_handler.dart';

import '../models/confession_viewmodel.dart';
// import '../providers/location_provider.dart';
import '../providers/providers.dart';
import '../services/firestore_services.dart';

class ConfessionCard extends ConsumerWidget {
  final Confession confession;
  final ConfessionCardViewModel confessionLocator;

  const ConfessionCard(
      {Key? key, required this.confession, required this.confessionLocator})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final locationAsyncValue = ref.watch(locationProvider);

    return Scaffold(
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(49, 44, 43, 43),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '@${confession.isAnonymous ? 'Anonymous' : confession.username}',
                          style: const TextStyle(
                            fontFamily: "Product Sans Bold",
                            fontSize: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.location_pin,
                        size: 14.0,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        locationAsyncValue.when(
                          data: (locationName) => locationName,
                          loading: () => 'Loading...',
                          error: (error, stackTrace) => 'Error: $error',
                        ),
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: "Product Sans Regular",
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                                onTap: () {
                                  // TODO: Implement edit functionality
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                                onTap: () {
                                  ref
                                      .read(firestoreProvider)
                                      .deleteConfession(confession.id);
                                  Navigator.pop(
                                      context); // Close the modal after deleting
                                },
                              ),
                              // Add more ListTiles for other actions
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                confession.content,
                style: const TextStyle(fontFamily: "Producst Sans Regular"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                        onPressed: () => ref
                            .read(firestoreProvider)
                            .upvoteConfession(confession.id),
                      ),
                      Text(confession.upvotes.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_down_alt_outlined),
                        onPressed: () => ref
                            .read(firestoreProvider)
                            .downvoteConfession(confession.id),
                      ),
                      Text(confession.downvotes.toString()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
