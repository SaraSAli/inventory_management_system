import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_company_screen.dart';
import 'company_details_screen.dart';

class SearchCompanyScreen extends StatefulWidget {
  const SearchCompanyScreen({Key? key}) : super(key: key);

  @override
  State<SearchCompanyScreen> createState() => _SearchCompanyScreenState();
}

class _SearchCompanyScreenState extends State<SearchCompanyScreen> {

  String name = "";
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search Company');

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
          stream: FirebaseFirestore.instance.collection('company').snapshots(),
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
                      List medicinesList = snapshot.data!.docChanges[index].doc['medicine'];
                      print('Medicine: $medicinesList');
                      if (name.isEmpty) {
                        return ListTile(
                          title: Text(
                            data['name'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text('Phone: ${data['phone']}'),
                          trailing: Container(
                            width: 25,
                            child: PopupMenuButton(
                              onSelected: (dynamic value) {
                                if (value == "Details") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CompanyDetailsScreen(//name: snapshot.data!.docChanges[index].doc['name']
                                        name: snapshot.data!.docChanges[index].doc['name'],
                                        phone: snapshot.data!.docChanges[index].doc['phone'],
                                        list: medicinesList,),
                                    ),
                                  );
                                }
                                if (value == "Delete")
                                  document.reference.delete();
                              },
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Details',
                                  child: Text('Details'),
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
                          subtitle: Text('Phone: ${data['phone']}'),
                          trailing: Container(
                            width: 25,
                            child: PopupMenuButton(
                              onSelected: (dynamic value) {
                                if (value == "Details") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CompanyDetailsScreen(//name: snapshot.data!.docChanges[index].doc['name']
                                        name: snapshot.data!.docChanges[index].doc['name'],
                                        phone: snapshot.data!.docChanges[index].doc['phone'],
                                        list: medicinesList,),
                                    ),
                                  );
                                }
                                if (value == "Delete")
                                  document.reference.delete();
                              },
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Details',
                                  child: Text('Details'),
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
                  builder: (context) => AddCompanyScreen()));
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),

/*
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
                .collection('medicine')
                .where("name", arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance.collection("medicine").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //DocumentSnapshot data = snapshot.data!.docs[index];
                    var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Text(
                            data['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
*/
        );

/*
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Medicine'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Search medicine'),
              onChanged: (query){
                searchFromFirebase(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _allResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _allResults[index]['name'],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${_allResults[index]['price']}'),
                      Text('Quantity: ${_allResults[index]['quantity']}'),
                      Text(
                          'Expiry Date: ${_allResults[index]['expiryDate'].toDate().toString()}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
*/
  }
}
