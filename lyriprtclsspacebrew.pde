import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import spacebrew.*;


String server="sandbox.spacebrew.cc";
String name="chat?";
String description ="This is an blank example client that publishes .... and also listens to ...";
String[] questions;

boolean yes1 = false, yes2 = false, yes = true;
boolean next1 = false, next2 = false, next = false;

Spacebrew sb;

Minim minim;
AudioPlayer player;
AudioSource in;
BeatDetect beat;
int buffersize;
float leftbuffer[], rightbuffer[];
float mixbuffer[];
float leftvolume, rightvolume;
float damper = 0.8;

ArrayList<Particle> particles, movers;
ArrayList<Attractor> attractors;

String musicfile;

RFont font; 
RGroup group;
RPoint[] points;

String lyric; 
int timingindex = 1;
int[] timing;

void setup() {
  size(1300, 650, OPENGL);
  //size(1440, 900, OPENGL);
  background(0);

  String[] temp = {
    "What are you most grateful for?", "What is your most treasured memory?", "What is your greatest goal?", "What thing is too serious to joke about?"
  };

  questions = temp;


  // instantiate the sb variable
  sb = new Spacebrew( this );


  // add each thing you subscribe to
  sb.addSubscribe("text", "string" );
  
  // add each thing you subscribe to
  sb.addSubscribe("yes1", "boolean" );
  
  // add each thing you subscribe to
  sb.addSubscribe("yes2", "boolean" );
  
   // add each thing you subscribe to
  sb.addSubscribe("next1", "boolean" );
  
  // add each thing you subscribe to
  sb.addSubscribe("next2", "boolean" );

  // connect to spacebrew
  sb.connect(server, name, description );

  minim = new Minim(this);
  initializeMusic();
  getMusicData();

  lyric = questions[0];


  RG.init(this);
  setupType();

  loadLyrics();
  timing = getTimingData();
  //lyric = getNextLyric();

  makeParticles();
  drawParticles();
  makeMoverParticles();
  drawMovers();

  initializeVoice();
}

void draw() {
  background(0);
  if(next1 && next2) next = true;

  int now = millis();
  if ((timingindex <questions.length) && next) {
    lyric = questions[timingindex];
    timingindex++;
    next1 = false;
    next2 = false;
    next = false;
  }
  
  if(yes1 && yes2) yes = true;
  
  if((timingindex == questions.length) && (yes)){
   lyric = "<3  <3  <3  <3";  
  }

  setPointsFromText(lyric);
  //setPointsFromText(getSpokenWords());

  createAttractorParticles();
  setAttraction();

  getMusicData();
  drawMovers();
  drawParticles();


  if (frameCount > 5) {
    varyParticleSizeToWaveForm();
    steerParticles();
  }
  beat.detect(leftbuffer);
  if (beat.isOnset()) {
    for (int i = 0; i < movers.size (); i++) {
      movers.get(i).expand();
    }

    for (int i = 0; i < particles.size (); i++) {
      //particles.get(i).expand();
    }

    if (now  >= 117489) {

      for (int i = 0; i < particles.size (); i++) {
        color temp[] = { 
          color(247, 207, 10, random(170, 200)), 
          color(252, 231, 13, random(170, 200)), 
          color(175, 230, 41, random(170, 200)), 
          color(255, 20, 147, random(170, 200)), 
          color(48, 196, 201, random(170, 200))
        };
        particles.get(i).colarray = temp;
        particles.get(i).randomizeColor();
      }
    }

    if (now >= timing[4]) {
      applyForceAccordingToWaveForm();
    }

    if (now  >= timing[7]) {

      for (int i = 0; i < movers.size (); i++) {
        color temp[] = { 
          color(247, 207, 10, random(100, 120)), 
          color(252, 231, 13, random(100, 120)), 
          color(175, 230, 41, random(100, 120)), 
          color(255, 20, 147, random(100, 120)), 
          color(48, 196, 201, random(100, 120))
        };
        movers.get(i).colarray = temp;
        movers.get(i).randomizeColor();
      }
    }
  }

  //text(millis(), width-100, height-100);
}

void onStringMessage( String name, String value ) {
  lyric = value;
}

void onBooleanMessage( String name, boolean value ) {
  println("received " + name);
  println("value " + value);
  if(name == "yes1") {
    yes1 = true;
  }
  else if(name == "yes2") { 
    yes2 = true;
  }
  else 
    if(name.equals("next1")) {
      next1 = true;
      println("received next1");
      
    }
  else if(name.equals("next2")) {
    next2 = true;
    println("received next2");
    
  }
}

