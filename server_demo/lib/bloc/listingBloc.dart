import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_demo/bloc/TaskListState.dart';
import 'package:server_demo/bloc/taskListingEvents.dart';
import 'package:server_demo/repository.dart';

class TaskListingBloc extends Bloc<TaskListingEvent,ListingState>{

  final TaskRepo repo;
  TaskListingBloc(this.repo);
  @override
  ListingState get initialState => ListFetchingState();

  @override
  Stream<ListingState> mapEventToState(TaskListingEvent event)async* {
    List<dynamic> tasks;
    try{
      if(event is AssTaskEvent)
      {
        tasks=await repo.fetchAssTasks(event.id);
      }
      else if(event is SelfTaskEvent)
      {
        print('in self task event');
        tasks=await repo.fetchSelfTask(event.id);
      }
      if(tasks.length==0)
      {
        yield ListEmptyState();
      }
      else{
        yield ListFectchedState(tasks);
      }
    }
    catch(_){
      yield ListErrorState();
    }
  }
  
}