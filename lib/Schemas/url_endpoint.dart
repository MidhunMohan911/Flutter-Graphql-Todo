import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_todo/Utils/url.dart';

class EndPoint {
  // we are gonna use the type of graphql client so ValueNotifier helps us to return the graphql client
  // that we can use to make our graphql client
  // that we can use to make our graphql request like pull mutation which is for positt query which is to get

  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(endpointUrl),
        cache: GraphQLCache(
          store:
              HiveStore(), // helps you to fetch from cache fetch from internet even if you don't have internet connection you can still get your data
        ),
      ),
    );
    return _client;
  }
}
