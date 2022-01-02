import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todonoteapp/provider/note_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final notecontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Note App'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the some text';
                  }
                },
                controller: notecontroller,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xffD6DDE1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: const BorderSide(color: Color(0xffD6DDE1)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref.read(noteprovider).onsavednote(notecontroller.text);
                _formKey.currentState!.save();
                notecontroller.clear();
                _formKey.currentState!.reset();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note Added'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
          const ShowListView(),
        ],
      ),
    );
  }
}

class ShowListView extends ConsumerWidget {
  const ShowListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(noteprovider);
    return data.notelist.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                itemCount: data.notelist.length,
                itemBuilder: (context, index) {
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(data.notelist[index]),
                        trailing: IconButton(
                            onPressed: () {
                              ref.read(noteprovider).removenote(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Note Remove'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ));
                }))
        : const Text('No Note Display');
  }
}
