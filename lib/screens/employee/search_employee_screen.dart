import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_employee_screen.dart';
import 'edit_employee_screen.dart';

class SearchEmployeeScreen extends StatefulWidget {
  const SearchEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<SearchEmployeeScreen> createState() => _SearchEmployeeScreenState();
}

class _SearchEmployeeScreenState extends State<SearchEmployeeScreen> {

  String name = "";
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search Employee');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('employee').snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      if (name.isEmpty) {
                        return ListTile(
                          title: Text(
                            data['name'],
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
                                                  employeeId: data['nationalId'],
                                                  employeeName: data['name'],
                                                  employeePhone: data['phone'],
                                                  employeeSalary:
                                                  data['salary'])));
                                }
                                if (value == "Delete")
                                  document.reference.delete();
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
                        );
                      }
                      if(data['name'].toString().toLowerCase().contains(name.toLowerCase())){
                        return ListTile(
                          title: Text(
                            data['name'],
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
                                                  employeeId: data['nationalId'],
                                                  employeeName: data['name'],
                                                  employeePhone: data['phone'],
                                                  employeeSalary:
                                                  data['salary'])));
                                }
                                if (value == "Delete")
                                  document.reference.delete();
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
                        );
                      }
                      else return Container(
                        child: Center(child: Text('No data found')),
                      );
                    });
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEmployeeScreen()));
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ),
        );
  }
}
