import '../../../shared/models/property_model.dart';

abstract class Search_States {}

class Initial_SearchStates extends Search_States {}

class addprice extends Search_States {}

class itemloading extends Search_States {}

class SearchLoading extends Search_States {}

final class ChangeIsFoveateSuccessg extends Search_States {
  final bool isFoveate;
  ChangeIsFoveateSuccessg({required this.isFoveate});
}

class Searchsuccess extends Search_States {
  final List<PropertyModel> properties;

  Searchsuccess({required this.properties});
}

class SearchFailure extends Search_States {
  final String errorMessage;

  SearchFailure({required this.errorMessage});
}

class addspace extends Search_States {}

class addcovernorates extends Search_States {}

class addregion extends Search_States {}
