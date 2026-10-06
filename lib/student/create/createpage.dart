
import 'package:abu/student/read/index.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePages extends StatefulWidget {
const CreatePages({super.key});

@override
State<CreatePages> createState() => _CreatePagesState();
}

class _CreatePagesState extends State<CreatePages> {
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

bool isLoading = false;

Future<void> addStudent() async {
// Check empty fields
if (nameController.text.trim().isEmpty ||
emailController.text.trim().isEmpty ||
phoneController.text.trim().isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
backgroundColor: Colors.red,
content: Text("Please fill all inputs!"),
),
);
return;
}

setState(() {
isLoading = true;
});

try {
print("🔥 SUBMIT BUTTON CLICKED");

// Send data to Firebase Firestore
final docRef = await FirebaseFirestore.instance.collection('student').add({
'name': nameController.text.trim(),
'email': emailController.text.trim(),
'phone': phoneController.text.trim(),
'createdAt': FieldValue.serverTimestamp(),
});

print("✅ DATA FIREBASE MEIN CHALA GAYA (doc id: ${docRef.id})");

if (!mounted) return;

// Clear input fields
nameController.clear();
emailController.clear();
phoneController.clear();

// Success message
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
backgroundColor: Colors.green,
content: Text("Student data submitted successfully!"),
),
);
} catch (e) {
print("❌ FIREBASE ERROR: $e");


if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
backgroundColor: Colors.red,
content: Text("Firebase Error: $e"),
),
);
} finally {
if (mounted) {
setState(() {
isLoading = false;
});
}
}
}

@override
void dispose() {
nameController.dispose();
emailController.dispose();
phoneController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
"Input Section",
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 20,
),
),
centerTitle: true,
  actions: [
    IconButton(onPressed:(){ Navigator.push(context,MaterialPageRoute(builder:(context)=> Readpages()));
    },icon: Icon(Icons.people_alt_outlined)),

  ],
),


body: Padding(
padding: const EdgeInsets.all(20),

child: Column(
children: [
TextField(
controller: nameController,
decoration: const InputDecoration(
labelText: "Write your name",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 20),

TextField(
controller: emailController,
keyboardType: TextInputType.emailAddress,
decoration: const InputDecoration(
labelText: "Write your email",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 20),

TextField(
controller: phoneController,
keyboardType: TextInputType.phone,
decoration: const InputDecoration(
labelText: "Write your phone",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 25),

SizedBox(
width: double.infinity,
height: 55,

child: ElevatedButton(
onPressed: isLoading ? null : addStudent,

style: ElevatedButton.styleFrom(
backgroundColor: Colors.orange,
foregroundColor: Colors.white,

shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
),
),

child: isLoading
? const CircularProgressIndicator(
color: Colors.white,
)
    : const Text(
"Submit",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),
),
],
),
),
);
}
}