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

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>
    with TickerProviderStateMixin
{
  final _formKey = GlobalKey<FormState>();

  static const welcomeStyle=TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold
  );
  static const linkStyle=TextStyle(
    decoration:TextDecoration.underline,
    color:Colors.blue
  );
  late final TabController _tabController = TabController(vsync: this, length: 1, initialIndex: 0);

  bool isSignin=true;

  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme=context.select((ThemeBloc bloc) => bloc.state.theme);
    final auth=context.select((AuthenticationBloc bloc) => bloc);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:const Text("Calendar It"),
          // title: Text(auth.toString()),
          actions: [
            IconButton(
                onPressed: ()=>{
                  if(theme==AppTheme.darkMode){
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(theme:AppTheme.lightMode))
                  }
                  else{
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(theme:AppTheme.darkMode)
                    )
                  }
                },
                icon:theme==AppTheme.lightMode?
                const Icon(Icons.light_mode,size: 18,):
                const FaIcon(FontAwesomeIcons.solidMoon,size: 15,)
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width*0.05,
              vertical: 20
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Text("Hello ",
                style: welcomeStyle.copyWith(
                color: theme==AppTheme.lightMode?Colors.black87:DarkTheme.quaternary
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Text(
                isSignin?"Sign in to get started":"Sign up and get started",
                style: welcomeStyle.copyWith(
                  color:theme==AppTheme.lightMode?Colors.black87:DarkTheme.quaternary
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Form(
                key:_formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: formFieldStyle(theme).copyWith(
                          hintText: "email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email cannot be empty';
                          }
                          else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                            return "Invalid Email";
                          }
                          return null;
                        },
                        style:formsTextStyle(theme),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: formFieldStyle(theme).copyWith(
                          hintText: "password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          else if(value.length<=8){
                            return "Password must be more than 8 characters";
                          }
                          return null;
                        },
                        style:formsTextStyle(theme).copyWith(
                          letterSpacing: 2
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    print("Validated");
                                    if(isSignin){
                                      print("Email n Password Signin");
                                      BlocProvider.of<AuthenticationBloc>(context).add(
                                          SignIn(
                                              isGoogleSignin:false,
                                              email:emailController.text,
                                              password: passwordController.text
                                          )
                                      );

                                    }else{
                                      print("Email n Password Signup");
                                    }
                                  }
                                  else{
                                    print("Invalid");
                                  }


                                },
                                child:isSignin?const Text("Sign In"):const Text("Sign Up"),
                                style: ButtonStyle(
                                    padding:MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:15
                                        )
                                    ),
                                    backgroundColor:MaterialStateProperty.all(LightTheme.primary),
                                    foregroundColor: MaterialStateProperty.all(LightTheme.quaternary),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            // side: const BorderSide(color: Colors.red)
                                        )
                                    )
                                )
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton.icon(
                                onPressed: ()=>{

                                },
                                label:const Text("Google"),
                                icon:const Icon(FontAwesomeIcons.google,size: 15,),
                                style: ButtonStyle(
                                    padding:MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical:15
                                        )
                                    ),
                                    foregroundColor:MaterialStateProperty.all(LightTheme.primary),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            // side: const BorderSide(color: Colors.red)
                                        )
                                    )
                                )
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: isSignin?
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color:theme==AppTheme.lightMode?Colors.black87:DarkTheme.quaternary,
                      fontSize: 15
                  ),
                ):
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      color:theme==AppTheme.lightMode?Colors.black87:DarkTheme.quaternary,
                      fontSize: 15

                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: ()=>{
                    setState(() {
                      isSignin=!isSignin;
                    })
                  },
                    child:
                    isSignin?
                    const Text("Sign Up",style: linkStyle,):
                        const Text("SignIn",style: linkStyle)
                ),
              ),
            ],
          ),
        ),
        backgroundColor: theme==AppTheme.lightMode?LightTheme.quaternary:DarkTheme.secondary,
      ),
    );
  }
}
