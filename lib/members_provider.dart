import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_datastax/secret.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dio = Dio(
  BaseOptions(
    contentType: "application/json",
    headers: {"X-Cassandra-Token": ASTRA_DB_APPLICATION_TOKEN},
  ),
);

final membersProvider = FutureProvider.autoDispose<String>((ref) async {
  final members = await dio
      .get(
          "https://$ASTRA_DB_ID-$ASTRA_DB_REGION.apps.astra.datastax.com/api/rest/v1/keyspaces/$ASTRA_DB_KEYSPACE/tables/members/rows")
      .then((value) => value.data);
  ref.keepAlive();
  return members['rows'][0].toString();
});
