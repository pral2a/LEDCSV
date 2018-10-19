class Bar {

  int[][] data = {};

  int barWidth = 100;

  color[][]timeColor;

  int timeColorSel = 0, nextTimeColorSel= 0, prevColorSel = 0;

  boolean testMode;

  PVector pos;

  int rangeMax = 30;

  long totalRiseTime = 100;
  long riseTime = 0;
  long startRiseTime = 0;

  long waitTime = 1000;
  long startWaitTime = 0;

  int v1, v2;

  int step = 0;
  int state = 1;
  float amt = 0;
  float vN = 0;


  Bar(int[][] myA, int myXPos, long myTotalRiseTime, long myTotalWaitTime, color[][]myTimeColor, int myBarsWidth) {
    data = myA;
    totalRiseTime = myTotalRiseTime;
    waitTime = myTotalWaitTime;
    barWidth =  myBarsWidth;
    pos = new PVector(myXPos, 0);
    timeColor = myTimeColor;
    setStepInfo();
  }

  int update(boolean myTestMode) {
    testMode = myTestMode;
    updateState();
    doState();
    drawRect();
    return step;
  }

  void doState() {
    switch(state) {
    case 1: 
      move();
      break;
    case 2: 
      justArrived();
      break;
    case 3: 
      nextStep();
      break;
    default:             
      break;
    }
  }

  void updateState() {
    if (amt >= 1.0) {
      if (state == 1) {
        state = 2;
      } else {
        state = 3;
      }
    } else {
      state = 1;
    }
  }

  void move() {
    long timeSpent = millis() - startRiseTime;
    amt = map(timeSpent, 0, totalRiseTime, 0, 1);
    vN = lerp(v1, v2, sin(amt));
  }

  void justArrived() {
    startWaitTime = millis();
  }

  void nextStep() {
    if (waitTime <= millis() - startWaitTime) {
      step++;
      if (step >= data.length) {
        step = 0;
      }
      setStepInfo();
    }
  }


  void setStepInfo() {
    v1 = data[step][1];

    if (step+1 >= data.length) {
      v2 = data[0][1];
      nextTimeColorSel = data[0][0];
    } else {
      v2 = data[step+1][1];
      nextTimeColorSel = data[step+1][0];
    }

    amt = 0;
    prevColorSel = timeColorSel;
    timeColorSel = data[step][0];
    startRiseTime = millis();
  }


  void drawRect() {
    int barHeight = height - int(map(vN, 0, rangeMax, 0, height));
    setGradient(int(pos.x), int(pos.y), barWidth-1, height, timeColor[timeColorSel][0], timeColor[timeColorSel][1]);
    dayNightTransition();
    noStroke();  
    fill(0);
    if (testMode == false) return;
    rect(pos.x, pos.y, barWidth + pos.x, barHeight);
  }

  void dayNightTransition() {
    float alpha = 0;
    if (timeColorSel != nextTimeColorSel) {
      alpha = abs(map(amt, 0, 1, 0, 255));
    } else if (prevColorSel != timeColorSel) {
      alpha = abs(map(amt, 0, 1, 255, 0));
    } 
    noStroke();  
    fill(0, 0, 0, alpha);
    rect(pos.x, pos.y, barWidth + pos.x, height);
  }

  void setGradient(int x, int y, float w, float h, color c1, color c2) {
    noFill();
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
}
