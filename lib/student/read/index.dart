
import 'package:abu/student/update/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Readpages extends StatefulWidget {
const Readpages({super.key});

@override
State<Readpages> createState() => _ReadpagesState();
}

class _ReadpagesState extends State<Readpages> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Students Read"),
centerTitle: true,
),

body: StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance
    .collection('student')
    .snapshots(),

builder: (context, snapshot) {
// Loading
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(),
);
}

// Error
if (snapshot.hasError) {
return Center(
child: Text("Error: ${snapshot.error}"),
);
}

// No data
if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
return const Center(
child: Text("No students found"),
);
}

final students = snapshot.data!.docs;

return ListView.builder(
itemCount: students.length,

itemBuilder: (context, index) {
final student = students[index];

return ListTile(
title: Text(
student['name'] ?? '',
),

subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
student['email'] ?? '',
),
Text(
student['phone'] ?? '',
),
],
),

trailing: Row(
mainAxisSize: MainAxisSize.min,
children: [

// DELETE
IconButton(
onPressed: () async {
final messenger =
ScaffoldMessenger.of(context);

await FirebaseFirestore.instance
    .collection('student')
    .doc(student.id)
    .delete();

messenger.showSnackBar(
const SnackBar(
content: Text(
"Student data deleted successfully!",
),
),
);
},

icon: const Icon(
Icons.delete,
color: Colors.red,
),
),

const SizedBox(width: 10),

// UPDATE
IconButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => Updatepage(
id: student.id,
name: student['name'],
email: student['email'],
phone: student['phone'],
),
),
);
},

icon: const Icon(
Icons.edit,
),
),
],
),
);
},
);
},
),
);
}
}

