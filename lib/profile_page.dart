import 'package:flutter/material.dart';
import 'package:webio/provider/zk_login_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ZkLoginProvider provider = ZkLoginProvider.getInstance();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await provider.executeGetUserComponents(context, provider.address);
          print('done executeGetUserComponents');
        },
      ),
      body: FutureBuilder(
        future: provider.executeGetComponent(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Center(
              child: Text('data: ${data}'),
            );
            print('data: $data');
          } else if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
