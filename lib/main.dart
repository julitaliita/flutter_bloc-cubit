import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_counter_bloc/app.dart';
import 'package:flutter_counter_bloc/counter_observe.dart';

void main() {
  Bloc.observer = const CounterObserver();
  runApp(CounterApp());
}