import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_employee_screen.dart';
import 'edit_employee_screen.dart';


class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  final Stream<QuerySnapshot> _employeeStream = FirebaseFirestore.instance
      .collection('employee')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle, size: 32),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEmployeeScreen()));
              })
        ],
        title: Text('Employees'),
      ),
      body: StreamBuilder(
        stream: _employeeStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['name'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Salary: \$${snapshot.data!.docChanges[index].doc['salary']}'),
                              Text(
                                  'Phone number: ${snapshot.data!.docChanges[index].doc['phone']}'),
                              Text(
                                  'National Id: ${snapshot.data!.docChanges[index].doc['nationalId']}'),
                            ],
                          ),
                          trailing: Container(
                            width: 25,
                            child: PopupMenuButton(
                              onSelected: (dynamic value) {
                                if (value == "Edit") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditEmployeeScreen(
                                                  employeeId: snapshot
                                                      .data!
                                                      .docChanges[index]
                                                      .doc['nationalId'],
                                                  employeeName: snapshot
                                                      .data!
                                                      .docChanges[index]
                                                      .doc['name'],
                                                  employeeSalary: snapshot
                                                      .data!
                                                      .docChanges[index]
                                                      .doc['salary'],
                                                  employeePhone: snapshot
                                                      .data!
                                                      .docChanges[index]
                                                      .doc['phone'])));
                                }
                                if (value == "Delete")
                                  document.reference.delete();
                                  /*showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                              title: Text('Delete Item',
                                                  textAlign: TextAlign.center),
                                              content: Text(
                                                  'Are you sure you want to delete this item?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance.collection("employee")
                                                          .doc(snapshot
                                                          .data!
                                                          .docChanges[index]
                                                          .doc['nationalId']).delete();
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('YES')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('NO')),
                                              ]));*/
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
