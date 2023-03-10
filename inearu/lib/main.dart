import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inearu/bloc/counter/counter_bloc.dart';
import 'package:inearu/bloc/login/login_bloc.dart';
import 'package:inearu/bloc/profile/profile_bloc.dart';
import 'package:inearu/config/app_router.dart';
import 'package:inearu/config/custom_theme.dart';
import 'package:inearu/cubit/cubit/counter_cubit.dart';
import 'package:inearu/models/profile_model.dart';

import 'package:inearu/bloc/swipe_bloc.dart';
import 'package:inearu/pages/UserScreen.dart';
import 'package:inearu/pages/bloc_counter.dart';
import 'package:inearu/pages/onboarding_screen.dart';
import 'package:inearu/pages/user_detail_screen.dart';
import 'package:inearu/screen/login_screen.dart';
import 'package:inearu/test_pages/profile_page.dart';
import 'package:inearu/test_pages/stream_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => CounterCubitBloc(0)),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(
            create: (_) => SwipeBloc()..add(LoadUsers(users: User.users))),
        BlocProvider(create: (context) => LoginBloc()),
      ],
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          final initialRoute = snapshot.data?.getString('token') != null
              ? UserScreen.routename
              : OnboardingScreen.routename;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }
}
