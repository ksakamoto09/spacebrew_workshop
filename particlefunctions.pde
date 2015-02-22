void makeParticles() {
  particles = new ArrayList<Particle>();

  for (int i = 0; i < mixbuffer.length  ; i++) {
    //float leftwaveformvalue = leftbuffer[i];
    float xleft = random(0, width);
    float yleft = random(0, height);

    particles.add(new Particle());
  }
}


void makeMoverParticles() {

  movers = new ArrayList<Particle>();

  for (int i = 0; i < mixbuffer.length/4  ; i++) {
    //float leftwaveformvalue = leftbuffer[i];
    float xleft = random(0, width);
    float yleft = random(0, height);

    movers.add(new Particle());
  }

  for (int i = 0; i < movers.size(); i++) {


    //movers.get(i).col = color(255, random(50, 100));
//    color temp[] = { 
//      color(247, 207, 10, random(170, 200)), 
//      color(252, 231, 13, random(170, 200)), 
//      color(175, 230, 41, random(170, 200)), 
//      color(255, 20, 147, random(170, 200))
//    };

 color temp[] = { 
      color( random(170, 200)), 
      color( random(170, 200)), 
      color(random(170, 200)), 
      color( random(170, 200))
    };
    movers.get(i).colarray = temp;

    movers.get(i).col = color(random(50, 120));
    movers.get(i).size = random(10, 15);
  }
}



void createAttractorParticles() {
  attractors = new ArrayList<Attractor>();
  for (int i =0; i < points.length; i++) {
    Attractor temp = new Attractor();
    temp.location = new PVector(map(points[i].x, -500, 500, width/2-500, width/2+500), map(points[i].y, -150, 150, height/2-150, height/2+150));
    //temp.location = new PVector(width/2, height/2);
    attractors.add(temp);
    //println("attractor " + i + "'s x is at " + attractors.get(i).location.x + " and " + attractors.get(i).location.y);
  }
}


void createAttractorParticles2(int y1_, int y2_) {
  attractors = new ArrayList<Attractor>();
  for (int i =0; i < points.length; i++) {
    Attractor temp = new Attractor();
    temp.location = new PVector(map(points[i].x, -500, 500, width/2-500, width/2+500), map(points[i].y, -150, 150, height/2-y1_, height/2+150));
    //temp.location = new PVector(width/2, height/2);
    attractors.add(temp);
    //println("attractor " + i + "'s x is at " + attractors.get(i).location.x + " and " + attractors.get(i).location.y);
  }
}




void drawParticles() {
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).run();
  }
}

void drawMovers() {
  for (int i = 0; i < movers.size(); i++) {
    movers.get(i).run();
    //movers.get(i).steer();
    //movers.get(i).shift();
  }
}



void setAttraction() {
  for (int i = 0; i < particles.size(); i++) {
    //int index = int(random(0, attractors.size()-1));
    particles.get(i).assignTarget(attractors.get(i%attractors.size()));
    //particles.get(i).maxforce = 10/63000; 
    //println("attractor " + index + " was attached to particle " + i);
  }
}


void steerParticles() {
  for (int i =0; i < particles.size(); i++) {
    particles.get(i).steer();
  }
}




void applyForceAccordingToWaveForm() {
  for (int i = 0; i < movers.size(); i++) {
    float mixwaveformvalue = mixbuffer[i];
    movers.get(i).applyForce(new PVector(map(mixwaveformvalue, -1, 1, -10, 10), 0));
    //println(leftwaveformvalue);
  }
}



void varyParticleSizeToWaveForm() {
  for (int i = 0; i < particles.size(); i++) {
    float mixwaveformvalue = mixbuffer[i];
    float size = map(mixwaveformvalue, -1, 1, 5, 7);
    size = damper*size + (1-damper) * mixwaveformvalue * 10 +2;
    particles.get(i).size = size;

    //println(leftwaveformvalue);
  }
}

void varyParticleSizeToBeat() {
  for (int i = 0; i < movers.size(); i++) {
    float mixwaveformvalue = mixbuffer[i];
    float size = map(mixwaveformvalue, -1, 1, 5, 50);
    size = damper*size + (1-damper) * mixwaveformvalue * 20 +2;
    particles.get(i).size = size;

    //println(leftwaveformvalue);
  }
}
