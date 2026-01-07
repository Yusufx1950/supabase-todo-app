import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'http://172.23.177.169:54321',
    anonKey: 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realtime Todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();
  final _client = Supabase.instance.client;

  Future<void> _addTodo() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('todos').insert({
      'user_id': user.id,
      'title': _controller.text,
    });
    _controller.clear();
  }

  Future<void> _toggleTodo(String id, bool isComplete) async {
    await _client
        .from('todos')
        .update({'is_complete': !isComplete})
        .eq('id', id);
  }

  Future<void> _deleteTodo(String id) async {
    await _client.from('todos').delete().eq('id', id);
    print("Todo Silindi");
  }

  @override
  Widget build(BuildContext context) {
    final user = _client.auth.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text("Önce giriş yapmalısın")));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Realtime Todo")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Yeni todo ekle...",
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTodo),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _client
                  .from('todos')
                  .stream(primaryKey: ['id']), // id tabloda primary key olmalı
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final todos = snapshot.data!;
                if (todos.isEmpty) {
                  return const Center(child: Text("Henüz todo yok"));
                }
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo['title']),
                      leading: Checkbox(
                        value: todo['is_complete'] ?? false,
                        onChanged: (_) => _toggleTodo(
                          todo['id'],
                          todo['is_complete'] ?? false,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTodo(todo['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
