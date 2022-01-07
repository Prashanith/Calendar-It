import 'package:calendar_it/bloc/authBLOC/auth_bloc.dart';
import 'package:calendar_it/bloc/themeBLOC/theme_bloc.dart';
import 'package:calendar_it/constants/theme_file.dart';
import 'package:calendar_it/global_ui/forms.dart';
import 'package:calendar_it/services/firestore_service.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _dateTime=DateTime.now();

  final _formKey = GlobalKey<FormState>();

  TextEditingController task =TextEditingController(text: "");
  TextEditingController description =TextEditingController(text: "");

  bool isLoading=false;

  void showToast(String msg){
    Fluttertoast.showToast(
        msg:msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  Future addTask()async{
    try{
      setState(() {
        isLoading=true;
      });
      await createTask(task: task.text, description: description.text, dateTime: _dateTime);
      showToast("Task Created Successfully");
      setState(() {
        isLoading=false;
      });
    }
    catch(e){
      setState(() {
        isLoading=false;
      });
      showToast("Task Creation Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme=context.select((ThemeBloc bloc) => bloc.state.theme);
    final auth=context.select((AuthenticationBloc bloc) => bloc.state.userCredential.user!.uid);

    return Container(
      padding:const EdgeInsets.fromLTRB(20,35,20,10),
      width: MediaQuery.of(context).size.height*0.86,
      decoration: BoxDecoration(
          color: theme==AppTheme.lightMode?LightTheme.quaternary:DarkTheme.secondary,
          borderRadius:BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.width*0.06),
            topRight:Radius.circular(MediaQuery.of(context).size.width*0.06),
          )
      ),
      child: SingleChildScrollView(
        child:isLoading?
        const Center(
          child: CircularProgressIndicator(),
        ):
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const Text(
                "CREATE TASK",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding:const EdgeInsets.only(left:4,bottom: 6),
                child: Text(
                  "task",
                  style: TextStyle(
                      color:theme==AppTheme.lightMode?Colors.black:Colors.grey
                  ),
                ),
              ),
              TextFormField(
                controller: task,
                decoration: formFieldStyle(theme).copyWith(),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Task Cannot be Empty';
                  }
                  return null;
                },
                style:formsTextStyle(theme),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding:const EdgeInsets.only(left:4,bottom: 6),
                child: Text(
                  "description",
                  style: TextStyle(
                      color:theme==AppTheme.lightMode?Colors.black:Colors.grey
                  ),
                ),
              ),
              TextFormField(
                controller: description,
                decoration: formFieldStyle(theme).copyWith(
                ),
                validator: (value) {
                  if (value == null || value.isEmpty ) {
                    return 'Description cannot be Empty';
                  }
                  return null;
                },
                style:formsTextStyle(theme),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding:const EdgeInsets.only(left:4,bottom: 6),
                child: DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMM, yy HH:mm',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days:7)),
                  icon: const Icon(FontAwesomeIcons.calendar),
                  dateLabelText: 'task time',
                  timeLabelText: "Hour",
                  onChanged: (val) {
                    setState(() {
                      _dateTime = DateTime.parse(val);
                    });
                  },
                  validator: (val) {
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      _dateTime = DateTime.parse(val!);
                    });
                  },
                ),
              ),
              const SizedBox(height: 50,),
              Align(
                alignment:Alignment.center,
                child: TextButton(
                    onPressed: ()async{
                      if (_formKey.currentState!.validate()) {
                        await addTask();
                      }
                    },
                    style: ButtonStyle(
                      padding:MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 10,horizontal: 15)
                      ),
                      shape:MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          )
                      ),
                      elevation:MaterialStateProperty.all(10),
                      foregroundColor: MaterialStateProperty.all(LightTheme.quaternary),
                      backgroundColor:
                      theme==AppTheme.lightMode?
                      MaterialStateProperty.all(LightTheme.secondary)
                            :MaterialStateProperty.all(DarkTheme.secondary)
                    ),
                    child:const Text("Create",style: TextStyle(letterSpacing: 0.7),)
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
