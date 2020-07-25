abstract class ListingState{}

// class notstarted extends ListingState{}

class ListFetchingState extends ListingState{}

class ListFectchedState extends ListingState{
  final List<dynamic> tasks;

  ListFectchedState(this.tasks);
}

class ListErrorState extends ListingState{}

class ListEmptyState extends ListingState{}