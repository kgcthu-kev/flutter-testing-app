import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app/models/user/user.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://randomuser.me/api/?results=50';

enum Genders { all, male, female }

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Genders selectedGender = Genders.all;
  late List<User> userList;
  bool isLoading = true;
  void fetchUserList() async {
    String url = '$baseUrl&gender=${selectedGender.name}';
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    final datas = responseData['results'] as List<dynamic>;

    userList = datas.map((data) => User.fromJson(data)).toList();

    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    print(userList.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users page'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            // <-- SEE HERE
                            title: const Text('Select Booking Type'),
                            children: <Widget>[
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('General'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Silver'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Gold'),
                              ),
                            ],
                          ));
                },
                icon: const Icon(Icons.tune))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: Genders.values
                    .map((e) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: FilterChip(
                              selected: selectedGender == e,
                              label: Text(e.name),
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedGender = e;
                                  isLoading = true;
                                  fetchUserList();
                                });
                              }),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: isLoading ? 10 : userList.length,
                  itemBuilder: (context, index) {
                    return isLoading
                        ? _buildLoadingItem()
                        : UserSingleItem(user: userList[index]);
                  }),
            ),
          ],
        ));
  }
}

class UserSingleItem extends StatelessWidget {
  const UserSingleItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            user.picture.thumbnail,
            height: 50,
            width: 50,
          ),
        ),
        title: Text(user.name.fullname),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(user.email), Text(user.gender)],
        ),
      ),
    );
  }
}

Widget _buildLoadingItem() {
  return Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey.shade300,
    child: ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        width: 50,
        height: 50,
      ),
      title: Container(
        width: double.infinity,
        height: 20,
        color: Colors.grey[300],
      ),
      subtitle: Container(
        width: double.infinity,
        height: 15,
        color: Colors.grey[300],
      ),
    ),
  );
}
