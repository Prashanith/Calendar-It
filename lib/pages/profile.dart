import 'dart:convert';
import 'package:calendar_it/bloc/authBLOC/auth_bloc.dart';
import 'package:calendar_it/bloc/authBLOC/auth_event.dart';
import 'package:calendar_it/bloc/themeBLOC/theme_bloc.dart';
import 'package:calendar_it/bloc/themeBLOC/theme_event.dart';
import 'package:calendar_it/constants/theme_file.dart';
import 'package:calendar_it/global_ui/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  @override
  Widget build(BuildContext context) {
    final theme=context.select((ThemeBloc bloc) => bloc.state.theme);


    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*0.05,
          vertical: 20
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key:_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:const EdgeInsets.only(left:4,bottom: 6),
                    child: Text(
                        "Username",
                      style: TextStyle(
                          color:theme==AppTheme.lightMode?Colors.black:Colors.grey
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: formFieldStyle(theme).copyWith(),
                    style:formsTextStyle(theme),

                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding:const EdgeInsets.only(left:4,bottom: 6),
                    child: Text(
                        "Email",
                      style: TextStyle(
                          color:theme==AppTheme.lightMode?Colors.black:Colors.grey
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: formFieldStyle(theme).copyWith(
                    ),
                    style:formsTextStyle(theme),
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: ()=>{},
                        style: ButtonStyle(
                          elevation:MaterialStateProperty.all(10),
                          backgroundColor:
                          theme==AppTheme.lightMode?
                          MaterialStateProperty.all(LightTheme.secondary)
                              :MaterialStateProperty.all(DarkTheme.secondary)
                        ),
                        child:const Text("Edit Profile")
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: (){
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(const SignOut());
                        },
                        style: ButtonStyle(
                            elevation:MaterialStateProperty.all(10),
                            backgroundColor:
                            theme==AppTheme.lightMode?
                            MaterialStateProperty.all(LightTheme.secondary)
                                :MaterialStateProperty.all(DarkTheme.secondary)
                        ),
                        child:const Text("get out")
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
