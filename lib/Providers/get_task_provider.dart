import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_todo/Schemas/add_task_schema.dart';
import 'package:graphql_todo/Schemas/get_task_schema.dart';
import 'package:graphql_todo/Schemas/url_endpoint.dart';

class GetTaskProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  dynamic _list = [];

  bool get getStatus => _status;

  String get getResponse => _response;

  EndPoint _point = EndPoint();

  // Add Task Method
  void getTask(bool isLocal) async {
  
    notifyListeners();

    ValueNotifier<GraphQLClient> _client = _point.getClient();
     QueryResult result = await _client.value.query(QueryOptions(
        document: gql(GetTaskSchema.getTaskJson),
        fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly));
    if (result.hasException) {
      print(result.exception);
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = 'Internet not found';
      } else {
        _response = result.exception!.graphqlErrors[0].toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status = false;
      _list = result.data;
      notifyListeners();
    }
  }

  dynamic getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;
      return data['getTodos'] ?? {};
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
