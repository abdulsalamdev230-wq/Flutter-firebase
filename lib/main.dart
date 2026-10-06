
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:abu/student/create/createpage.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

try {
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

} catch (e) {
print("❌ FIREBASE INIT FAILED: $e");
runApp(MaterialApp(home: Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(20), child: Text("Firebase Init Error:\n$e", textAlign: TextAlign.center))))));
return;
}
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
home: const CreatePages(),
);
}
}