void setupType() {
  font = new RFont("NeutraText-Bold.ttf", 64, CENTER);

  RCommand.setSegmentLength(8);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
}

void setPointsFromText(String text_) {
  String[] q = splitTokens(text_);

  group = font.toGroup(text_);
  group = group.toPolygonGroup();

  points = group.getPoints();
  int y_ = 0;
  if (q.length > 5) {
    //    for(int i = 0; i < q.length; i++){
    //      
    //    }
  } else {
  }
}

