import 'package:flutter/material.dart';
import 'package:flutter_http/modules/reqresApi/provider/reqres_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constant.dart';

class ReqresView extends StatelessWidget {
  const ReqresView({super.key});

  @override
  Widget build(BuildContext context) {
    final jsonHolderProvider = context.read<ReqresProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('JsonHolder'),
      ),
      body: RefreshIndicator(
          onRefresh: () => jsonHolderProvider.getUserData(),
          child: Consumer<ReqresProvider>(
            builder: (context, value, child) {
              return value.isLoading || value.isError
                  ? AppConstant.kLoading
                  : _userList(value);
            },
          )),
    );
  }

  Widget _userList(ReqresProvider value) {
    return ListView.builder(
      itemCount: value.userDataList.length,
      itemBuilder: (context, i) {
        final data = value.userDataList[i];
        return ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(data.avatar)),
          title: Text('${data.first_name} ${data.last_name}'),
          subtitle: Text(data.email),
          trailing: Text(data.id.toString()),
        );
      },
    );
  }
}
