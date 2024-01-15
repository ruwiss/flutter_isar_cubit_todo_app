import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/data/dataproviders/isar_database.dart';
import 'ui/data/repositories/todo_repository_impl.dart';
import 'ui/logic/cubits/todo_cubit.dart';
import 'ui/presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = IsarDatabase();
  await db.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TodoCubit>(
        create: (context) => TodoCubit(TodoRepositoryImpl()),
        child: const HomeScreen(),
      ),
    );
  }
}
