import 'package:flutter/material.dart';
import 'package:sqflite_sample_program/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  int? selectedInded;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
                controller: c1, decoration: InputDecoration(hintText: "name")),
            TextField(
                controller: c2,
                decoration: InputDecoration(hintText: "designation")),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      //fuction to save data to database

                      await HomeScreenController.addDataToDb(
                          des: c2.text, name: c1.text);
                      await HomeScreenController.getAllDataFromDb();
                      setState(() {});
                    },
                    child: Text("save")),
                ElevatedButton(
                    onPressed: () async {
                      //fuction to save data to database
                      await HomeScreenController.editData(
                          des: c2.text,
                          name: c1.text,
                          id: HomeScreenController.data[selectedInded!]["id"]);
                      setState(() {});
                    },
                    child: Text("edit")),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: HomeScreenController.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                child: Row(
                  children: [
                    Text(
                        "${HomeScreenController.data[index]["name"]}, ${HomeScreenController.data[index]["des"]}"),
                    Spacer(),
                    InkWell(
                        onTap: () async {
                          c1.text = HomeScreenController.data[index]["name"]
                              .toString();

                          c2.text = HomeScreenController.data[index]["des"]
                              .toString();
                          selectedInded = index;

                          setState(() {});
                        },
                        child: Icon(Icons.edit)),
                    SizedBox(width: 10),
                    InkWell(
                        onTap: () async {
                          await HomeScreenController.deleteData(
                              HomeScreenController.data[index]["id"]);
                          setState(() {});
                        },
                        child: Icon(Icons.delete)),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
