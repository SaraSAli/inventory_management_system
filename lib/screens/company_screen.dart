import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'company_details_screen.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});
  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _companyStream = FirebaseFirestore.instance
        .collection('company')
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Companies'),
          actions: <Widget>[
          ],
        ),
      body: StreamBuilder(
        stream: _companyStream,
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
                List medicinesList = snapshot.data!.docChanges[index].doc['medicine'];
                print('Medicine: $medicinesList');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyDetailsScreen(//name: snapshot.data!.docChanges[index].doc['name']
                          name: snapshot.data!.docChanges[index].doc['name'],
                          phone: snapshot.data!.docChanges[index].doc['phone'],
                          list: medicinesList,),
                      ),
                    );
                  },
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
                          /*onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => CompanyDetailsScreen(
                              name: snapshot.data!.docChanges[index].doc['name'],
                              phone: snapshot.data!.docChanges[index].doc['phone'],
                              list: medicinesList,
                            ))
                            );
                          },*/
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
                              Text('Phone: \$${snapshot.data!.docChanges[index].doc['phone']}'),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
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
class DeltaItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: Center(
        child: Text('List of items goes here'),
      ),
    );
  }
}
class EIPICOItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: Center(
        child: Text('List of items goes here'),
      ),
    );
  }
}
class PharcoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: Center(
        child: Text('List of items goes here'),
      ),
    );
  }
}