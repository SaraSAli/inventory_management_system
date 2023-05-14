import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_medicine_screen.dart';
import 'edit_medicine_screen.dart';

class SearchMedicineScreen extends StatefulWidget {
  const SearchMedicineScreen({Key? key}) : super(key: key);

  @override
  State<SearchMedicineScreen> createState() => _SearchMedicineScreenState();
}

class _SearchMedicineScreenState extends State<SearchMedicineScreen> {

  String name = "";
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search Medicine');
  late Timestamp timestamp;

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
          stream: FirebaseFirestore.instance.collection('medicine').snapshots(),
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
                      timestamp = data['expiryDate'];
                      DateTime dateTime = timestamp.toDate();
                      bool isToday = DateTime.now().day >= dateTime.day;
                      Color color = isToday ? Colors.red : Colors.white;
                      if (name.isEmpty) {
                        return Container(
                          color: color,
                          child: ListTile(
                            leading: isToday ? Icon(Icons.warning, color: Colors.white) : null,
                            title: Text(
                              data['name'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: \$${data['price']}'),
                                Text('Quantity: ${data['quantity']}'),
                                Text(
                                    'Expiry Date: ${data['expiryDate'].toDate().toString()}'),
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
                                                EditMedicineScreen(
                                                    medicineId: data['id'],
                                                    medicineName: data['name'],
                                                    medicinePrice: data['price'],
                                                    medicineQuantity:
                                                    data['quantity'])));
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
                          ),
                        );
                      }
                      if(data['name'].toString().toLowerCase().contains(name.toLowerCase())){
                        return Container(
                          color: color,
                          child: ListTile(
                            leading: isToday ? Icon(Icons.warning, color: Colors.white) : null,
                            title: Text(
                              data['name'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: \$${data['price']}'),
                                Text('Quantity: ${data['quantity']}'),
                                Text(
                                    'Expiry Date: ${data['expiryDate'].toDate().toString()}'),
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
                                                EditMedicineScreen(
                                                    medicineId: data['id'],
                                                    medicineName: data['name'],
                                                    medicinePrice: data['price'],
                                                    medicineQuantity:
                                                    data['quantity'])));
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
                          ),
                        );
                      }
                      else return Container();
                    });
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddMedicineScreen()));
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ),
        );
  }
}
