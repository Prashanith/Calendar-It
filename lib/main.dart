import 'package:calendar_it/bloc/authBLOC/auth_bloc.dart';
import 'package:calendar_it/bloc/authBLOC/auth_state.dart';
import 'package:calendar_it/constants/theme_file.dart';
import 'package:calendar_it/pages/Tasks/add_task.dart';
import 'package:calendar_it/pages/profile.dart';
import 'package:calendar_it/routes/error_page.dart';
import 'package:calendar_it/routes/routegenerator.dart';
import 'package:calendar_it/widgets/bottomnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/themeBLOC/theme_bloc.dart';
import 'bloc/themeBLOC/theme_event.dart';
import 'bloc/themeBLOC/theme_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context)=>ThemeBloc(AppTheme.lightMode),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context)=>AuthenticationBloc(const UnAuthenticated()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder:(context,state){
          return MaterialApp(
            title: 'Calendar It',
            theme:state.theme==AppTheme.lightMode?ThemeData(
              appBarTheme:const AppBarTheme(
                color: LightTheme.primary,
                foregroundColor: LightTheme.quaternary,
              ),
              backgroundColor:LightTheme.quaternary,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor:LightTheme.secondary,
                selectedIconTheme:IconThemeData(
                  size: 20,
                  color: LightTheme.quaternary,
                ),
                unselectedIconTheme:IconThemeData(
                  size: 20,
                  color: LightTheme.primary,
                ),
                selectedLabelStyle:TextStyle(fontSize: 0),
                unselectedLabelStyle:TextStyle(fontSize: 0),
                unselectedItemColor: LightTheme.quaternary,
              ),
            ):
            ThemeData(
              appBarTheme:const AppBarTheme(
                color: DarkTheme.primary,
                foregroundColor: DarkTheme.quaternary,
              ),
              backgroundColor: DarkTheme.primary,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor:DarkTheme.secondary,
                selectedIconTheme:IconThemeData(
                  size: 20,
                  color: DarkTheme.quaternary,
                ),
                unselectedIconTheme:IconThemeData(
                  size: 20,
                  color: Colors.grey,
                ),
                selectedLabelStyle:TextStyle(fontSize: 0),
                unselectedLabelStyle:TextStyle(fontSize: 0),
                unselectedItemColor: DarkTheme.quaternary,
              ),
            ),
            initialRoute: '/',
            onGenerateRoute:RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int page = 0;
  static const List<Widget> widgets=[
    Text("Home"),
    Text("Calendar"),
    Text("Create"),
    Profile(),
  ];

  void switchPage(int pos){
    setState(() {
      page=pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme=context.select((ThemeBloc bloc) => bloc.state.theme);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme==AppTheme.lightMode?LightTheme.quaternary:DarkTheme.secondary,
        appBar: AppBar(
          elevation: 0,
          leading: const Center(
              child: FaIcon(
                FontAwesomeIcons.feather,
                size: 18,
              )
          ),
          title:Text(widget.title),
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
        body: widgets[page],
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          backgroundColor:theme==AppTheme.lightMode?LightTheme.quaternary:DarkTheme.quaternary,
          foregroundColor: LightTheme.primary,
          onPressed:()=>{
            showModalBottomSheet(
              constraints:  BoxConstraints(
                minHeight: MediaQuery.of(context).size.height*0.65,
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MediaQuery.of(context).size.width*0.2),
                  topRight:Radius.circular(MediaQuery.of(context).size.width*0.2),
                )
              ),
              context: context,
              builder: (BuildContext context) {
                return const AddTask();
              },
            )
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar:NavigationBar(pageNumber:page,switchPage:switchPage,),
      ),
    );
  }
}




