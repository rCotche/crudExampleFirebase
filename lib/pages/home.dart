import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_example_firebase/pages/employee.dart';
import 'package:crud_example_firebase/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  //
  Stream? employeeStream;

  //met a jour le widget avec les employee details
  void getOnTheLoad() async {
    employeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    locationController.dispose();
    super.dispose();
  }

  //Read widget
  Widget allEmployeeDetails() {
    //
    return StreamBuilder(
        stream: employeeStream,
        builder: ((context, snapshot) {
          //Si il y a des employee return a list view builder avec le employee
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot unEmployee = snapshot.data.docs[index];

                    //ui pour listé les amployee
                    //creer un component pour cette partie
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        //
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name
                              Row(
                                children: [
                                  Text(
                                    "Name: ${unEmployee["Name"]}",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  //
                                  GestureDetector(
                                    onTap: () {
                                      nameController.text = unEmployee["Name"];
                                      ageController.text = unEmployee["Age"];
                                      locationController.text =
                                          unEmployee["Location"];
                                      editEmployeeDetails(unEmployee["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  //
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteEmployeeDetails(
                                              unEmployee["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              //Age
                              Text(
                                "Age: ${unEmployee["Age"]}",
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //Location
                              Text(
                                "Location: ${unEmployee["Location"]}",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Text("lol");
        }));
  }

  //
  Future<void> editEmployeeDetails(String id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel),
                        ),
                        //?
                        const SizedBox(
                          width: 60,
                        ),
                        const Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //
                    //name
                    const Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //age
                    const Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: ageController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //location
                    const Text(
                      'Location',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: locationController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    //
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          //
                          Map<String, dynamic> updateInfo = {
                            "Id": id,
                            "Name": nameController.text,
                            "Age": ageController.text,
                            "Location": locationController.text,
                          };
                          await DatabaseMethods()
                              .addEmployeeDetails(updateInfo, id)
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text(
                          "Update",
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,//fonctionne pas
        //parce ça utilise une Row mettre le titre je suppose
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Firebase',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 20,
          top: 30,
          right: 20,
        ),
        child: Column(
          children: [
            //doit ê un component
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const Employee()),
            ),
          );
        },
        label: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
