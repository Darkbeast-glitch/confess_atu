import 'package:confess_atu/models/confessions.dart';
import 'package:confess_atu/providers/confession_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/firestore_services.dart';

// provider for confessionNotifier Provider and i will eb be gool
final confessionNotifierProvider =
    StateNotifierProvider.family<ConfessionNotifier, Confession, dynamic>(
        (ref, confession) {
  return ConfessionNotifier(confession);
});

final confessionsProvider = StreamProvider<List<Confession>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore.getConfessionsStream();
});

// Define a provider to handle permission requests
final permissionStatusProvider = FutureProvider<PermissionStatus>((ref) async {
  return await Permission.location.request();
});

// location provider
final locationProvider = FutureProvider<String>((ref) async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemarks[0];
  return "${place.locality}, ${place.country}";
});
