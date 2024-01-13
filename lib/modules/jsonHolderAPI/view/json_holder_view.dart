import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constant.dart';
import '../provider/json_holder_provider.dart';

class JsonHolderView extends StatelessWidget {
  const JsonHolderView({super.key});

  @override
  Widget build(BuildContext context) {
    final jsonHolderProvider = context.read<JsonHolderProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('JsonHolder'),
      ),
      body: RefreshIndicator(
          onRefresh: () => jsonHolderProvider.getPostData(),
          child: Consumer<JsonHolderProvider>(
            builder: (context, value, child) {
              return value.isLoading || value.isError
                  ? AppConstant.kLoading
                  : _userList(value);
            },
          )),
    );
  }

  Widget _userList(JsonHolderProvider value) {
    return ListView.builder(
      itemCount: value.userPostList.length,
      itemBuilder: (context, i) {
        final items = value.userPostList[i];
        return ListTile(
          leading: CircleAvatar(child: Text(items.id.toString())),
          title: Text(items.title.toString()),
          subtitle: Text(items.body.toString()),
          trailing: Text(items.userId.toString()),
        );
      },
    );
  }
}
