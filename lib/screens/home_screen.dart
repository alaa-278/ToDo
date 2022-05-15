import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/notes_screen.dart';
import 'package:todo_app/models/theme_data.dart';
import 'package:todo_app/screens/add_note_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor:  Color(0xff407BFF),
          onPressed: () {
            Get.bottomSheet(AddNote());
          },
          child: Icon(Icons.add,color:Get.isDarkMode?Colors.black:Colors.white,),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: (){
                  ThemeServices().switchTheme();
                },
                icon: Icon(Get.isDarkMode?Icons.wb_sunny_outlined:Icons.nightlight_round,color:Get.isDarkMode?Colors.black:Colors.white,),
              ),
            ),
          ],
          backgroundColor: Color(0xff407BFF),
          title: Text(
            'Hi, Welcome Alaa',
            style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600,color:Get.isDarkMode?Colors.black:Colors.white,fontFamily: 'Lobster'),
          ),
          bottom: TabBar(
            indicatorColor:Get.isDarkMode?Colors.white:Colors.black,
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'UnDone',
              ),
              Tab(
                text: 'Done',
              ),
              Tab(
                text: 'Before',
              ),
              Tab(
                text: 'After',
              ),

            ],
          ),
        ),
        body:
        TabBarView(
          children: [
            NotesScreen(FilterTypes.all),
            NotesScreen(FilterTypes.undone),
            NotesScreen(FilterTypes.done),
            NotesScreen(FilterTypes.before),
            NotesScreen(FilterTypes.after),
          ],

        ),


      ),
    );
  }
}

