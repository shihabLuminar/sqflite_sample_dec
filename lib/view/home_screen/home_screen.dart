import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_sample_program/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
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
            ElevatedButton(
                onPressed: () async {
//fuction to save data to database

                  await HomeScreenController.addDataToDb(
                      des: c2.text, name: c1.text);
                  await HomeScreenController.getAllDataFromDb();
                  setState(() {});
                },
                child: Text("save")),
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
                          await HomeScreenController.editData(
                              HomeScreenController.data[index]["id"]);
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
