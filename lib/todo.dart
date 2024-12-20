
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class Todopage extends StatefulWidget{
  @override
  State<Todopage> createState()=> _todopageState();
}

class _todopageState extends State<Todopage>{

TextEditingController taskContoller=TextEditingController();
late Box box;
List <String> todoitems=[];

  @override
  void loadTodoItems()async{
    
  }

    void saveTodoItems()async{
     await box.put("todiitems", todoitems); 
    }

  void addTodoItems(String task){
    if(task.isNotEmpty){
      setState(() {
        todoitems.add(task);
      });
    }
    saveTodoItems();
    taskContoller.clear();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Todo list",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                
                labelText: "Enter task",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),  
            ),

            SizedBox(height: 15,),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  return ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    title: Text(box.get("task"),style: TextStyle(fontSize: 18,color: const Color.fromARGB(255, 0, 0, 0)),),
                    tileColor:const Color.fromARGB(255, 231, 231, 231),
                    trailing: Icon(Icons.delete,color: const Color.fromARGB(255, 248, 201, 60)),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height: 15,);
                },
                itemCount: box.length)),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: (){
            box.put("task", taskContoller);
          },child: Text("+",style: TextStyle(fontSize: 30,color: Colors.white),),)),
    );
  }

}