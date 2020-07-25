abstract class TaskListingEvent{}

class AssTaskEvent extends TaskListingEvent{
  final int id;
  AssTaskEvent({this.id});
}

class SelfTaskEvent extends TaskListingEvent{
  final int id;
  SelfTaskEvent({this.id});
}