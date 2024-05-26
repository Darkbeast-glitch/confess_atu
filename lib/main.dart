import 'package:confess_atu/auth/auth.dart';
import 'package:confess_atu/firebase_options.dart';
import 'package:confess_atu/providers/providers.dart';
import 'package:confess_atu/theme/dark_mode.dart';
import 'package:confess_atu/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Confess ATU',
      home: FutureBuilder<PermissionStatus>(
          future: Permission.location.request(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data?.isGranted ?? false) {
              final locationFuture = ref.watch(locationProvider);
              return locationFuture.when(
                data: (locationName) => AuthPage(locationName: locationName),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text('Error: $error'),
              );
            } else {
              return const Text('Location permission not granted');
            }
          }),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}

// eturn FutureBuilder<PermissionStatus>(
//       future: ref.read(permissionProvider).request(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: SizedBox(
//               width: 50,
//               height: 50,
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (snapshot.data?.isGranted ?? false) {
//           return FutureBuilder<String>(
//             future: confessionLocator.getLocationName(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: SizedBox(
//                     width: 30,
//                     height: 30,
//                     child: CircularProgressIndicator(
//                       color: Theme.of(context).colorScheme.inversePrimary,
//                     ),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 String locationName = snapshot.data!;