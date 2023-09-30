import 'package:flutter/material.dart';

import 'contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //control text
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
//arry list

  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('contacts list'),
      ),
      // ignore: prefer_const_constructors
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            //controller
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Contact Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: contactController,
            keyboardType: TextInputType.number,
            maxLength: 11,
            decoration: InputDecoration(
                hintText: 'Contact Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    // trim== remove spacing
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      //add calue to empty list
                      setState(() {
                        nameController.text = '';
                        contactController.text = '';
                        contacts.add(Contact(name: name, contact: contact));
                      });
                    }
                    //
                  },
                  child: Text('Save')),
              ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();

                    if (name.isNotEmpty && contact.isNotEmpty) {
                      //add calue to empty list
                      setState(() {
                        nameController.text = '';
                        contactController.text = '';
                        //for new name & contc
                        contacts[selectedIndex].name = name;
                        contacts[selectedIndex].contact = contact;
                        selectedIndex = -1;
                      });
                    }
                  },
                  child: Text('Update')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          contacts.isEmpty
              ? Text('no conatct')
              : Expanded(
                  child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index)),
                ),
        ],
      ),
    );
  }

  getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          //for column left to right - cross align
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].name,
                style: TextStyle(
                    fontWeight: FontWeight
                        .bold)), //these two nam contac come from 'contact class
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  //
                  onTap: () {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  //
                  child: Icon(Icons.edit)),
              InkWell(
                  onTap: () {
                    //
                    setState(() {
                      //contacts list variable
                      contacts.removeAt(index);
                    });
                    //
                  },
                  child: Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
