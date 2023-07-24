import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/models/post.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  bool isLoading = true;
  // late Future<List<Post>> posts;
  // void fetchPosts() async {
  //   final response =
  //       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  //   final responseData = jsonDecode(response.body) as List<dynamic>;
  //   setState(() {
  //     posts = responseData.map((e) => Post.fromJson(e)).toList();
  //     isLoading = false;
  //   });
  //   print(posts[0].id);
  // }

  Future<List<Post>> getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Fail to load posts');
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts page')),
      body: FutureBuilder(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(snapshot.data![index].title),
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
