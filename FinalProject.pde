import gohai.simpletweet.*;
SimpleTweet simpletweet;

PImage bg = new PImage();
String seed = "";  
String txt = "";  //display text
String tweetTxt = "";   //a sentence for the tweet
PFont myFont;
boolean animate = false;
boolean post = false;
int animCount = 0;


//arrays of image choices
int numHead = 4;
int numHair = 24;
int numEyes = 4;
int numNose = 4;
int numMouth = 4;
int numBodies = 9;
int numThings = 6;
PImage[] head = new PImage[numHead];
PImage[] ears = new PImage[numHead];
PImage[] hands = new PImage[numHead];
PImage[] hair = new PImage[numHair];
PImage[] eyes = new PImage[numEyes];
PImage[] nose = new PImage[numNose];
PImage[] mouth = new PImage[numMouth];
PImage[] body = new PImage[numBodies];
PImage[] thing = new PImage[numThings];

void setup() {
  noCursor();
  size(1000, 600);
  bg = loadImage("bg.png");
  image(bg, 0, 0);
  simpletweet = new SimpleTweet(this);
  
  myFont = createFont("Georgia", 32);
  textFont(myFont);
  text("To generate a character, press G.\nPress P to tweet the result.\nPress Q to quit.", 300, 250);
  
  //OAuth Keys for my personal Twitter go here, they've been removed.
  
  //build component lists
  head = getList("head", numHead);
  eyes = getList("eyes", numEyes);
  nose = getList("nose", numNose);
  mouth = getList("mouth", numMouth);
  hair = getList("hair", numHair);
  ears = getList("ears", numHead);
  hands = getList("hands", numHead);
  body = getList("bodies", numBodies);
  thing = getList("things", numThings);
}

void draw(){
  if (animCount < height + 100 && animate){
    post = false;
    float amt = (float)animCount/(height+100);
    noStroke();
    fill(lerpColor(0, 255, amt));
    rect(0, height-animCount, width, 100, 10);
    animCount+= 10;
  }

 else if (animCount < 500 && post){
    text("Posted!", 550, height - 150);
    animCount++;
 }
   else 
    if (animate){
      generate();
      animate = false;
      animCount = 0;
    }
    else if (post){
    }
    else animate = false;
    
}

//generate the character, draw the images on the screen
void generate(){  

  seed = "";
  image(bg, 0, 0);
  
  int r1 = (int) random(0, numHead);  //head, hands, and ears choice
  int r2 = (int) random(0, numEyes);  //eyes choice
  int r3 = (int) random(0, numNose);  //nose choice
  int r4 = (int) random(0, numMouth);  //mouth choice
  int r5 = (int) random(0, numHair);    //hair choice
  int r6 = (int) random(0, 11);  //% getting elf ears
  int r7 = (int) random(0, 11);  //% getting a thing
  int r8 = (int) random(0, numThings);  //which thing
  int r9 = (int) random(0, numBodies);    //body choice
  
  fill(30, 30, 30, 100);
  noStroke();
  ellipse(350, 480, 200, 50);
  
  image(body[r9], 0, 0);
  image(head[r1], 0, 0);
  image(eyes[r2], 0, 0);
  image(nose[r3], 0, 0);
  image(mouth[r4], 0, 0);
  image(hair[r5], 0, 0);
  if (r6 > 7) image(ears[r1], 0, 0);  //30% chance of elf ears
  if (r7 > 5) image (thing[r8], 0, 0);  //50% chance of having a "thing"
  image(hands[r1], 0, 0);
  
  //create seed with component info
  seed += r1 + r2 + r3 + r4 + "." + r9 + "." + r5 + "." + r6 + "-" + r7 + "." + r8 ;
  
  //create identity texts
  txt = genString(r7, r8);  //for on-screen and in-image display
  tweetTxt = genTweetText(txt);  //for the tweet body text 
  
  fill(255);
  myFont = createFont("Georgia", 32);
  textFont(myFont);
  text(txt, 550, 150);

  println("> Generated from seed " + seed);
}

//generate identity info and build the text on the image
String genString(int p, int a){
  String r = "";

  //name
  int nA = (int) random(0, 6);
  int nB = (int) random(0, 5);
  int nC = (int) random(0, 6);
  r += genName(nA, nB, nC);
  
  //class
  int r1 = (int) random(0, 8);
  if (p > 5)
    r += genClass(a);
  else
    r += genClass(r1);
  
  //gender
  int r2 = (int) random(0, 3);
  r += genGender(r2);
  
  //guild
  int r3 = (int) random(0, 6);
  r += genGuild(r3);

  //update seed (add identity info)
  seed += "-" + r1 + "." + r2 + "." + r3 + "#" + nA + "." + nB + "." + nC;
  return r;
}

String genName(int nA, int nB, int nC){
  String r = "\nName: ";
  
  switch(nA){
    case 0: r += "La"; break;
    case 1: r += "Sa"; break; 
    case 2: r += "Yen"; break; 
    case 3: r += "Ki"; break;
    case 4: r += "An"; break;
    case 5: r += "Cai"; break;
  }
  switch(nB){
    case 0: r += "hi"; break;
    case 1: r += "ti"; break; 
    case 2: r += "no"; break; 
    case 3: r += "ra"; break;
    case 4: r += "ky"; break;
  }
  switch(nC){
    case 0: r += "ta"; break;
    case 1: r += "ry"; break; 
    case 2: r += "mi"; break; 
    case 3: r += "tor"; break;
    case 4: r += "fer"; break;
    case 5: r += "va"; break;
  }
  
  return r;
}

String genClass(int a){
  String r = "\nClass: "; 
  
  switch(a){
    case 0: r += "Townsperson"; break;
    case 1: r += "Swordsman"; break; 
    case 2: r += "Negotiator"; break; 
    case 3: r += "Royal"; break;
    case 4: r += "Archer"; break;
    case 5: r += "Mage"; break;
    case 6: r += "Farmer"; break;
    case 7: r += "None"; break;
  }
  
  return r;
}

String genGender(int r2){
  String r = "\nGender: ";
  
  switch(r2){
    case 0: r += "Male"; break;
    case 1: r += "Female"; break;
    case 2: r += "Nonbinary"; break;
  }
  
  return r;
}

String genGuild(int r3){
  String r = "\nGuild: ";
  
  switch(r3){
    case 0: r += "Royal Knights"; break; 
    case 1: r += "Ravenous Warriors"; break; 
    case 2: r += "Not affiliated"; break;
    case 3: r += "Silent Creed"; break;
    case 4: r += "Lodge of Artemis"; break;
    case 5: r += "Alchemist's Guild"; break;

  }
  return r;
}

String genTweetText(String s){
  String working = s;
  String r = "";
  
  String name = working.substring(7, working.indexOf("Class")-1);
  working = working.substring(working.indexOf("Class")-1);
  String clss = working.substring(8, working.indexOf("Gender")-1).toLowerCase();
  working = working.substring(working.indexOf("Gender")-1);
  String gender = working.substring(9, working.indexOf("Guild")-1).toLowerCase();
  working = working.substring(working.indexOf("Guild")-1);
  String guild = working.substring(8);
  
  if (clss.equals("none") && guild.equals("Not affiliated")) r = "A " + gender + " person named " + name + ".";
  else if (clss.equals("none")) r = "A " + gender + " person named " + name + ", member of the " + guild + ".";
  else if (guild.equals("Not affiliated")) r = "A " + gender + " " + clss + " named " + name + ".";
  else r = "A " + gender + " " + clss + " named " + name + ", member of the " + guild + ".";
  
  return r;
}

//user controls
void keyReleased() {
  if (key == 'p'){ 
    //String tweet = simpletweet.tweetImage(get(), tweetTxt + "\nMade with love by @itsannalog using #processing.\n\nGenerated via seed: " + seed);
    //println("> Posted! Tweet ID: " + tweet);
    println("> Posted! Well, sort of. Not really.The tweet would have said...\n");
    println(tweetTxt + "\nMade with love by @itsannalog using #processing.\nGenerated via seed: " + seed);
    
    post = true;
  }
  if (key == 'g'){
    animate = true;
    post = false;
  }
  if (key == 'q'){
    exit();
  }
}

PImage[] getList(String c, int n) {
  PImage[] items = new PImage[n];
  File dir = new File(sketchPath(c));
  File[] files = dir.listFiles();
  int i = 0;
  for (File f : files) {
    if (f.getName().endsWith(".PNG")) {
      items[i] = loadImage(c + "/" + f.getName());
      i++;
    }
  }
  return items;
}
