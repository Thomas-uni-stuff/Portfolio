/*  This class displays a visualisation of the number of streams for each artist
    This is visualised with moving music notes, that are represented in the respective colours of each artist
    The visualisation of the notes is layered, so the ones in the top will be more visible, and the ones lower down more opaque
    The program also allows you to move between each level, as there are 39 artists it would not be logical or even possible to display all at once
    There is a 'Level' display window, that signals to the user which level they are currently viewing
*/

class MusicNote {
  EachArtist sharedRef;
  String artists [];
  ArrayList<String> uniqueArtists = sharedRef.getUniqueArtists();
  String artistStreams [];
  ArrayList <Integer> eachArtistSteams;
  
  MusicNote(){
    
  }
}
