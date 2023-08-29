import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoPageView extends StatefulWidget {
  const TodoPageView({super.key});

  @override
  State<TodoPageView> createState() => _TodoPageViewState();
}

class _TodoPageViewState extends State<TodoPageView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = _auth.currentUser;
  }

  Future<void> _addToDo() async {
    final todoTitle = _todoController.text.trim();
    final dueDate = _dueDateController.text.trim();

    if (todoTitle.isNotEmpty && dueDate.isNotEmpty) {
      await _firestore
          .collection("users")
          .doc(_currentUser!.uid)
          .collection("todos")
          .add({
        'title': todoTitle,
        'timestamp': FieldValue.serverTimestamp(),
        'dueDate': dueDate
      });

      _todoController.clear();
      _dueDateController.clear();
    }
  }

  Future<void> _deleteToDo(String todoID) async {
    final todoDoc = _firestore
        .collection("users")
        .doc(_currentUser!.uid)
        .collection("todos")
        .doc(todoID);

    final todoData = (await todoDoc.get()).data() as Map<String, dynamic>;

    await todoDoc.delete();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("할 일이 삭제되었습니다!"),
      action: SnackBarAction(
        label: "취소",
        onPressed: () async {
          await todoDoc.set(todoData);
        },
      ),
    ));
  }

  List<Widget> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "To Do",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 251, 240, 178)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("할 일 추가"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _todoController,
                          decoration: InputDecoration(labelText: "할 일"),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _dueDateController,
                          decoration: InputDecoration(labelText: "기한"),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("취소")),
                      ElevatedButton(
                          onPressed: () {
                            _addToDo();
                            Navigator.pop(context);
                          },
                          child: Text("추가"))
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: _currentUser == null
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("users")
                    .doc(_currentUser!.uid)
                    .collection("todos")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("할 일이 없습니다."),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final todoData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        final todoTitle = todoData['title'] as String;
                        final dueDate = todoData['dueDate'] as String;
                        final todoID = snapshot.data!.docs[index].id;

                        return Dismissible(
                          key: Key(todoID),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _deleteToDo(todoID);
                          },
                          child: ListTile(
                            title: Text(todoTitle),
                            subtitle: Text("기한: $dueDate"),
                          ),
                        );
                      });
                }));
  }
}
