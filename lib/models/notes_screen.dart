import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:todo_app/models/database_service.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/screens/add_note_screen.dart';
import 'package:todo_app/screens/edit_screen.dart';
import '../models/note.dart';
import 'package:audioplayers/audioplayers.dart';
enum FilterTypes { undone, done, all, before, after }

class NotesScreen extends StatefulWidget {
  const NotesScreen(this.type, {Key? key}) : super(key: key);
  final FilterTypes type;


  @override
  State<NotesScreen> createState() => _NotesScreenState();
}
class _NotesScreenState extends State<NotesScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: Get.find<DatabaseController>().getAllNotes(widget.type),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            final data = snapshot.data;
            if(data!.isEmpty){
              return
                Column(
                  children: [
                    Image.asset('assets/images/No data.png'),
                    Text('There is no notes, let\'s add right now',style: TextStyle(
                      color: Colors.grey,fontWeight: FontWeight.w800,fontSize: 18
                    ),),
                  ],
                );
            }
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {

                  return Dismissible(
                    onDismissed: (dd) {
                      Get.find<DatabaseController>().deleteNote(data[index]);
                    },
                    background: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        child: Icon(Icons.delete_forever,color: Colors.white,),
                        height: 150,
                        color: Colors.black,
                        width: double.infinity,
                      ),
                    ),
                    key: Key(data[index].id.toString()),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.add_alert,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          subtitle: data[index].description == null
                              ? null
                              : Text(data[index].description!),
                          onTap: () {
                            AudioCache player = AudioCache(prefix: 'assets/sounds/');
                            player.play('done_task.wav');
                            Get.find<DatabaseController>()
                                .editNote(
                                data[index]..isDone = !data[index].isDone)
                                .then((value) => () {
                              setState(() {});
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowData(
                                        description:
                                        '${data[index].description}',
                                        image: data[index].base64Image,
                                        title: data[index].title)));
                          },
                          onLongPress: () {
                            Get.bottomSheet(AddNote(
                              previousNote: data[index],
                            )).then((value) {
                              setState(() {
                              });
                            });
                          },
                          trailing: Text(intl.DateFormat.yMd().add_jm().format(data[index].dateTime),style: TextStyle(
                              color: Get.isDarkMode ? Colors.white : Colors.black,fontWeight: FontWeight.bold
                          ),),
                          tileColor: data[index].color,
                          title: Text(
                            data[index].title,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
        }
      },
    );
  }
}
