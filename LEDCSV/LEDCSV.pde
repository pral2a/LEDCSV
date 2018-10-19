
/**

   ,--,                                       
,---.'|                                       
|   | :       ,---,.    ,---,      .--.--.    
:   : |     ,'  .' |  .'  .' `\   /  /    '.  
|   ' :   ,---.'   |,---.'     \ |  :  /`. /  
;   ; '   |   |   .'|   |  .`\  |;  |  |--`   
'   | |__ :   :  |-,:   : |  '  ||  :  ;_     
|   | :.'|:   |  ;/||   ' '  ;  : \  \    `.  
'   :    ;|   :   .''   | ;  .  |  `----.   \ 
|   |  ./ |   |  |-,|   | :  |  '  __ \  \  | 
;   : ;   '   :  ;/|'   : | /  ;  /  /`--'  / 
|   ,/    |   |    \|   | '` ,/  '--'.     /  
'---'     |   :   .';   :  .'      `--'---'   
          |   | ,'  |   ,.'                   
          `----'    '---'                     
                                              
Pral2a, 2018

Inputs a CSV file and generates a canvas to animate addressable LEDs.

HELP:

new Bars("NAME_OF_THE_CSV_FILE", movingTime, stopTime, gradientColors);

KEY CODES:

# SHIFT: Play / Stop
# TAB: LEDs Test Mode
# ENTER/RETURN: In Stop Mode moves one step ahead

**/

Bars pollutionLEDs;

color[] day = {color(255, 255, 0), color(0, 255, 0)}, 
        night = {color(255, 0, 0), color(0, 0, 255)};

color[][]timeColor = {day, night};

boolean play = true, testMode = true;

void setup() {
  background(0);
  size(700, 300);
  pollutionLEDs = new Bars("INDEX_BCN.csv", 1000, 1000, timeColor);
}

void draw() {
  if (!play) return;
  pollutionLEDs.update(testMode);
};

void keyPressed() {
  if (keyCode == SHIFT) {
    play = play ? false : true;
  } else if (keyCode == TAB) {
    testMode = testMode ? false : true;
  } else if (keyCode == ENTER || keyCode == RETURN) {
    pollutionLEDs.update(testMode);
  }
}
