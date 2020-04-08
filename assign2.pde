PImage bg,soil,groundhogIdle,life,soldier,cabbage;
PImage title,startHovered,startNormal;
PImage gameOver,restartHovered,restartNormal;


int measure=80;

//gamestate
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = 0; 



//soldier
int soldierY, soldierX, soldier_W,soldier_H;
//groundHoG position
int groundHogX,groundHogY,groundHog_W,groundHog_H;


//vegetable
int cabbageX=measure*floor(random(0,8));
int cabbageY=measure*floor(random(2,6));
int cabbage_W,cabbage_H=80;

//start botton  
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 360+60;
final int BUTTON_LEFT = 240;
final int BUTTON_RIGHT = 240+144;


//moving
boolean upPressed = false;
boolean downPressed= false;
boolean leftPressed=false;
boolean rightPressed=false;


//life
float lifenumber =2;


void setup() {
  frameRate = 60;
	size(640, 480, P2D);
	// Enter Your Setup Code Here


bg= loadImage("img/bg.jpg"); 
soil= loadImage("img/soil.png"); 
groundhogIdle= loadImage("img/groundhogIdle.png");
life= loadImage("img/life.png");
soldier= loadImage("img/soldier.png");
cabbage= loadImage("img/cabbage.png");

title= loadImage("img/title.jpg"); 
startHovered= loadImage("img/startHovered.png"); 
startNormal= loadImage("img/startNormal.png"); 
gameOver= loadImage("img/gameover.jpg"); 
restartHovered= loadImage("img/restartHovered.png"); 
restartNormal= loadImage("img/restartNormal.png"); 


groundHogX= 4*measure;
groundHogY= 1*measure ;
groundHog_W=groundHog_H =80;

soldierY=measure*floor(random(2,6));
soldierX=-80;
soldier_W=soldier_H =80;

cabbageX=measure*floor(random(0,8));
cabbageY=measure*floor(random(2,6));
cabbage_W=cabbage_H=80;


}

void draw() {
  


  
  
	// Switch Game State
switch(gameState){
  
      // Game Start
  case GAME_START:
  image(title,0,0);
  
        if(mouseX > BUTTON_LEFT  && mouseX < BUTTON_RIGHT
         && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
           
        image(startHovered, 248, 360);
        if(mousePressed){
          gameState = GAME_RUN; 
        }
      }else{
          image(startNormal,248,360);
      }
   
  break;
  
  
  
 
      // Game Run
  case GAME_RUN:
    
      //move
        if(upPressed){
        groundHogY-=80;
        if(groundHogY==measure*2||groundHogY==measure*3
        ||groundHogY==measure*4||groundHogY==measure*5){
          upPressed=!upPressed;
        }
      }
      
      if(downPressed){
       groundHogY+=80;
        if(groundHogY==measure*2||groundHogY==measure*3
        ||groundHogY==measure*4||groundHogY==measure*5){
          downPressed=!downPressed;
        }
      }
      
      if(rightPressed){
        groundHogX+=80;
          if(groundHogX==measure*2||groundHogX==measure*3
        ||groundHogX==measure*4||groundHogX==measure*5){
          rightPressed=!rightPressed;
        }
      }
      if(leftPressed){
        groundHogX-=80;
          if(groundHogX==measure*2||groundHogX==measure*3
        ||groundHogX==measure*4||groundHogX==measure*5){
          leftPressed=!leftPressed;
        }
      }
  
    
  //boundary detection
      if (groundHogX>width-1*groundHog_W){
        groundHogX=width-1*groundHog_W;
      }
      if (groundHogX<=0){
        groundHogX=0;
      }
      if (groundHogY>height-groundHog_H){
        groundHogY=height-groundHog_H;
      }
      if (groundHogY<measure){
        groundHogY=measure;
      }
  
    //soil
  image(bg,0,0);
image(soil,0,2*measure);

//grass
fill(124,204,25);
noStroke();
rect(0,2*measure-15,8*measure,15);

//sun
noStroke();
fill(255, 255, 0);
ellipse(590,50,130,130);
noStroke();
fill(253,184, 19);
ellipse(590,50,120,120);



//groundhog
image(groundhogIdle,groundHogX,groundHogY);


//soldier and its movement
image(soldier,soldierX,soldierY);
soldierX+=5;
soldierX%=640+80;


//vegetable

image(cabbage,cabbageX,cabbageY);
  

float lifeX = 10; 
float lifeY = 10;
float lifeSpacing = 70;




for(int i=0 ; i<lifenumber ; i++){
  
  lifeX = 10+i*lifeSpacing;
  image(life,lifeX,lifeY);
  
  }
  
      //touch the soldier
      if(soldierX<groundHogX+groundHog_W&& soldierX+soldier_W>groundHogX
      && soldierY<groundHogY+groundHog_W&& soldierY+soldier_W>groundHogY){
        groundHogX=measure*4;
        groundHogY=measure;
        lifenumber-=1;
      }
      //eat the cabbage
      if(cabbageX<groundHogX+groundHog_W&& cabbageX+cabbage_W>groundHogX
      && cabbageY<groundHogY+groundHog_W&& cabbageY+cabbage_H>groundHogY){
        cabbageX=640;
        cabbageY=480;
        lifenumber+=1;
      }
     if(lifenumber<0){
     gameState = 2;
     }      
      
  break;//gamestate
  
  
      // Game Lose
  case GAME_LOSE:
        image(gameOver,0,0);
        if(mouseX > BUTTON_LEFT  && mouseX < BUTTON_RIGHT
         && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
           
        image(restartHovered, 248, 360);
        if(mousePressed){
          lifenumber=2;
          gameState = GAME_RUN; 
        }
      }else{
          image(restartNormal,248,360);
      }
        
  
  
  
  break;
  
}



}






int lastTime=millis();;
int nowTime;
void keyPressed(){
 
  
  
  // up down right left
  if (key==CODED){
    
    switch(keyCode){
      
      case UP:
        upPressed=true;
        break;
        
      case DOWN:
        downPressed=true;
        break;
        
      case RIGHT:
        rightPressed=true;
        break;
        
      case LEFT:
        leftPressed=true;
        break;
        
    }
  }
}
        
void keyReleased(){
  if (key==CODED){
    switch(keyCode){
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
      case LEFT:
        leftPressed=false;
        break;
    }
  }
}
