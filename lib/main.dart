import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() {
  runApp( list());
}
class data {
  String tno="",t="";
  bool done=false;
  data({required this.tno,required this.t,required this.done}){}
 static List<data> todo(){
    return [
      data(tno:"1",t:"Wake up early",done:false),
    ];
  }
}
class list extends StatefulWidget {
  list({super.key});
  @override
  State createState()=>todolist();

}
class todolist extends State{
final controller=TextEditingController();
final List <data> hh=[data(tno: '1',t: 'hi',done: false)];
List<data> todo=data.todo();
List<data> found=[];
@override
void initState(){
  found=todo;
  super.initState();
}
Widget tio(data y){
  return Container(
    margin: EdgeInsets.fromLTRB(0,10,0,10),
      child:ListTile(
       tileColor: Colors.indigo,
       onTap: (){change(y);},
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          ),
       title:Text( y.t,
         style: TextStyle(decoration:y.done?TextDecoration.lineThrough:null,color:Colors.white,fontSize: 25,fontWeight: FontWeight.w400),
      ),
       leading: Icon(
                     y.done? Icons.check_box:Icons.check_box_outline_blank,
                     color: Colors.white,
   ),
      trailing:Container(
                 margin: EdgeInsets.all(5),
                 decoration: BoxDecoration(
                        color:Colors.red[500],
                        borderRadius: BorderRadius.circular(15)
  ),
                 child:IconButton(
                      icon:Icon(
                              Icons.delete,
                              color: Colors.white,),
                       onPressed: (){delete(y);},
  ),
  )
  )
  );
}
  @override
  Widget build(BuildContext context) {

    return GestureDetector(

        onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
      child:MaterialApp(
        home: Scaffold(
        //  resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                      size: 30
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000.0),
                      child: Image.network('https://cdn2.iconfinder.com/data/icons/people-occupation-job/64/Business-Employee-Manager-Boss-work-Avatar-Suit-512.png' ),
                    ),
                  )
                ],
              )

          ),
          body: Stack(
            children:[Container(
            padding:EdgeInsets.all(20),
            child:Column(
              children:[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 15,),
                  decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(100.0),
                    color: Colors.white
                  ),
                  child:TextField(
                    onChanged: (v)=>search(v),
                    style: TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      prefixIcon:Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black,
                      ),
                      prefixIconConstraints:BoxConstraints(maxHeight: 25,maxWidth: 40),
                      border:InputBorder.none,
                      hintText:"search",
                      hintStyle: TextStyle(color:Color.fromRGBO(0, 0, 0, 100),fontSize:25 )
                    ),
                  ),
                ),

                Text("To do List",
                    style:TextStyle(color: Colors.white,
                                    fontSize: 35,
                                     fontWeight: FontWeight.w700)),
                for(data i in found.reversed)
                  tio(i)
              ]
            ),
        ),
              Align(
                alignment: Alignment.bottomCenter,
                child:Row(
                  children:[
                    Expanded(child:Container(

                margin: EdgeInsets.all(15),
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(20.0),
                    color: Colors.white
                ),
                child:TextField( controller: controller,
                  style: TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      border:InputBorder.none,
                      hintText:"Add a new item ",
                      hintStyle: TextStyle(color:Color.fromRGBO(0, 0, 0, 100),fontSize:25 )
                  ),
                ),
              ),

                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(110,25,0,15),
                      child: ElevatedButton(
                        child: Text(
                          "+",
                          style: TextStyle(fontSize:30,fontWeight:FontWeight.w900 ),
                        ),
                        onPressed: (){addnew(controller.text);},

                      ),
                    )
                  ]
                ) ,
              )
      ]
    )

    )
    )
    );
  }
void delete(data y) {
  todo.remove(y);
  found.remove(y);
  setState(()=>());}
  void change(data y) {
    y.done=!y.done;
  setState(()=>());
}
void addnew(String u){
  todo.add(data(tno: DateTime.utc(2024, 1, 1).toString(),t:u,done: false));
  controller.clear();
  setState(()=>());
}
void search(String d){
  List<data> result=[];
  if(d.isEmpty){
    result=todo;
  }
  else{
    result=todo.where((item) => item.t!.toLowerCase().contains(d.toLowerCase())).toList();
  }
  setState(()=>{
    found=result
  }
  );
}
}