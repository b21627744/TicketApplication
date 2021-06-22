import 'package:flutter/material.dart';

import 'expeditionSearch.dart';

Widget _searchControl() {
  print(ExpeditionSearch.searchedExpeditions.length);
  if (ExpeditionSearch.searchedExpeditions.length != 0) {
    return Column(children: ExpeditionSearch.searchedExpeditions.toList());
  }
  return Center(
      child: Text("No flights were found matching your search criteria."));
}

class ExpeditionSearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expedition Search"),
      ),
      body: Container(
        child: _searchControl(),
      ),
    );
  }
}
