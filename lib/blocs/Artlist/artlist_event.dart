abstract class ArtlistEvent {}

class AddToArtlist extends ArtlistEvent {
  Map<String, dynamic> item;

  AddToArtlist(this.item);
}

class RemoveFromArtlist extends ArtlistEvent {
  Map<String, dynamic> item;

  RemoveFromArtlist(this.item);
}
