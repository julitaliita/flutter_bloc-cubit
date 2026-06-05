import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/auth/auth_cubit.dart';
import 'package:flutter_counter_bloc/categories/bloc/category_bloc.dart';
import 'package:flutter_counter_bloc/categories/repository/category_repository.dart';
import 'package:flutter_counter_bloc/categories/view/category_page.dart';
import 'package:flutter_counter_bloc/core/theme/theme_cubit.dart';
import 'package:flutter_counter_bloc/counter/cubit/counter_cubit.dart';
import 'package:flutter_counter_bloc/counter/view/counter_page.dart';
import 'package:flutter_counter_bloc/delete_account/bloc/delete_account_bloc.dart';
import 'package:flutter_counter_bloc/delete_account/repository/delete_account_repository.dart';
import 'package:flutter_counter_bloc/delete_account/view/delete_account.dart';
import 'package:flutter_counter_bloc/home/view/home_page.dart';
import 'package:flutter_counter_bloc/login/bloc/login_bloc.dart';
import 'package:flutter_counter_bloc/login/repository/login_repository.dart';
import 'package:flutter_counter_bloc/login/view/login_page.dart';
import 'package:flutter_counter_bloc/posts/bloc/post_bloc.dart';
import 'package:flutter_counter_bloc/posts/bloc/post_event.dart';
import 'package:flutter_counter_bloc/posts/view/posts_page.dart';
import 'package:flutter_counter_bloc/profile/bloc/profile_bloc.dart';
import 'package:flutter_counter_bloc/profile/repository/profile_repository.dart';
import 'package:flutter_counter_bloc/profile/view/profile_edit.dart';
import 'package:flutter_counter_bloc/profile/view/profile_page.dart';
import 'package:flutter_counter_bloc/register/bloc/register_bloc.dart';
import 'package:flutter_counter_bloc/register/repository/register_repository.dart';
import 'package:flutter_counter_bloc/register/view/register_page.dart';

import 'package:http/http.dart' as http;

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => LoginRepository(httpClient: http.Client()),
        ),
        RepositoryProvider(
          create: (_) => RegisterRepository(httpClient: http.Client()),
        ),
        RepositoryProvider(
          create: (_) => ProfileRepository(httpClient: http.Client()),
        ),
        RepositoryProvider(
          create: (_) => DeleteAccountRepository(httpClient: http.Client()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CounterCubit()),

          BlocProvider(
            create: (_) =>
                PostBloc(httpClient: http.Client())..add(PostFetched()),
          ),

          BlocProvider(create: (_) => ThemeCubit()),

          BlocProvider(create: (_) => AuthCubit()),

          BlocProvider(
            create: (context) =>
                LoginBloc(loginRepository: context.read<LoginRepository>()),
          ),

          BlocProvider(
            create: (context) => RegisterBloc(
              registerRepository: context.read<RegisterRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => ProfileBloc(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),

          // ✅ FIX: DELETE ACCOUNT BLOC (INI YANG KAMU BUTUHKAN)
          BlocProvider(
            create: (context) => DeleteAccountBloc(
              deleteAccountRepository: context.read<DeleteAccountRepository>(),
            ),
          ),

          BlocProvider(
            create: (_) => CategoryBloc(
              categoryRepository: CategoryRepository(httpClient: http.Client()),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: context.watch<ThemeCubit>().state,
              initialRoute: '/login',
              routes: {
                '/home': (_) => const HomePage(),
                '/counter': (_) => const CounterPage(),
                '/posts': (_) => const PostsPage(),
                '/login': (_) => const LoginPage(),
                '/register': (_) => const RegisterPage(),
                '/profile': (_) => const ProfilePage(),
                '/update-profile': (_) => const ProfileEdit(),
                '/delete-account': (_) => const DeleteAccountView(),
                '/categories': (context) => const CategoryPage(),
              },
            );
          },
        ),
      ),
    );
  }
}

