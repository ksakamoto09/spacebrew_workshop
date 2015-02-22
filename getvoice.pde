import com.getflourish.stt.*;
import javax.sound.sampled.*;

STT stt;
String result;

void initializeVoice() {
  stt = new STT(this);
  stt.enableDebug();
  stt.setLanguage("en"); 

  Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();

  for (int i = 0; i < mixerInfo.length; i++)
  {
    println("### " + i + ": " + mixerInfo[i].getName());
  }  

  Mixer mixer = AudioSystem.getMixer(mixerInfo[2]);

  Minim minim = stt.getMinimInstance();

  minim.setInputMixer(mixer);
  println("### Source set to: " + mixerInfo[0]);
}

String getSpokenWords() {
  stt.begin();
  String word = result;
  stt.end();
  
  return word;
}


void transcribe (String utterance, float confidence) 
{
  println(utterance);
  result = utterance;
}

