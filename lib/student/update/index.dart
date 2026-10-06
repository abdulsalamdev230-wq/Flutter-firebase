import 'package:abu/student/read/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updatepage extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final String phone;

  const Updatepage({super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.phone


  });

  @override
  State<Updatepage> createState() => _UpdatepageState();
}

class _UpdatepageState extends State<Updatepage> {
  late TextEditingController namecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController phonecontroller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller = TextEditingController(text: widget.name);
    emailcontroller = TextEditingController(text: widget.email);
    phonecontroller = TextEditingController(text: widget.phone);
  }
void updatestudent ()async{
    await FirebaseFirestore.instance.collection('student').doc(widget.id).update({
      'name': namecontroller.text,
      'email': emailcontroller.text,
      'phone':phonecontroller.text,
    });
    if(!mounted)return;
    Navigator.pop(context);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update  Student data ",style: TextStyle(fontWeight: .bold,fontSize: 20),),
        centerTitle: true,
      ),
      body: Column(
        children: [
        TextField(
        controller: namecontroller,
        decoration: const InputDecoration(
          labelText: "Write your name",
          border: OutlineInputBorder(),
        ),
      ),

        const SizedBox(height: 20),

        TextField(
          controller: emailcontroller,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Write your email",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          controller: phonecontroller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: "Write your phone",
            border: OutlineInputBorder(),
          ),
        ),

          SizedBox(height: 20,),


          TextButton(onPressed: updatestudent, child: Text(" update")),
]
      ),

    );
  }
}
