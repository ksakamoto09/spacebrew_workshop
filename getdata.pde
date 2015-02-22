processing.data.Table lyrics;
int lyricindex = 0;
void loadLyrics() {
  lyrics = loadTable("trueloves.csv", "header");
}

String getNextLyric() {
  TableRow row = lyrics.getRow(lyricindex); 
  String lyric = row.getString(1);
  lyricindex++;
  return lyric;
}

int[] getTimingData() {
  int[] timing = new int[lyrics.getRowCount()];

  for (int i = 0; i < lyrics.getRowCount(); i++) {

    TableRow row = lyrics.getRow(i);
    timing[i] = row.getInt(0);
    //println(timing[i]);
  }
  
  return timing; 
}


void initializeMusic() {
  musicfile = "04 True Loves.mp3";
  //musicfile = "spiller.mp3";
  //musicfile = "06 - Aurora Gone.mp3";
  buffersize = 1024;

  player = minim.loadFile(musicfile, buffersize);
  player.loop();

  in = (AudioSource)player;
  
  beat = new BeatDetect();
  beat.setSensitivity(10);
}

void getMusicData() {
  if (leftbuffer == null) {
    buffersize = in.bufferSize();
    //print(buffersize);
    leftbuffer = new float[buffersize];
    rightbuffer = new float[buffersize];
    mixbuffer = new float[buffersize];
  }

  for (int i = 0; i < buffersize; i++) {
    leftbuffer[i] = in.left.get(i);
    //println(in.left.get(i));
    rightbuffer[i] = in.right.get(i);
    //println(in.right.get(i));

    mixbuffer[i] = in.left.get(i)/in.left.level();
    //println(in.right.get(i));
  }
}
