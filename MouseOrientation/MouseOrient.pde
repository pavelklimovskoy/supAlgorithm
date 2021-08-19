// Программа для тестирования 
// алгоритма нанесения параллельных линий
//
// 07.08.2021

class Navigator
{
  public float _x1;
  public float _y1;
  public float _x2;
  public float _y2;
  
  Navigator() {
    this._x1 = 0;
    this._y1 = 0;
    this._x2 = 0;
    this._y2 = 0;
  }
  
  Navigator(float x1, float y1, float x2, float y2) {
    this._x1 = x1;
    this._y1 = y1;
    this._x2 = x2;
    this._y2 = y2;
  }
  
  void show() {
    line(_x1, _y1, _x2, _y2);
    
    fill(#00FF39);
    ellipse(_x1, _y1, 5, 5);
    ellipse(_x2, _y2, 5, 5);
  }
};

ArrayList<Navigator> navList = new ArrayList<Navigator>();

void setup() {
  size(800, 800);
  background(#FFFFFF);

}

float dif = 45;
float r = 200;
float t_x;
float t_y;

Navigator tmp = new Navigator();

void draw() {
  background(#FFFFFF);
   
  if(ClickCount == 0)
  {
    tmp._x1 = mouseX;
    tmp._y1 = mouseY;
    
  }
  if(ClickCount == 1)
  {
    tmp._x2 = mouseX;
    tmp._y2 = mouseY;
    
    float l = sqrt((tmp._x1 - mouseX)*(tmp._x1 - mouseX) + (tmp._y1 - mouseY)*(tmp._y1 - mouseY) );
    float quart = int((atan2((mouseY - tmp._y1 ), (mouseX - tmp._x1)) * 180 / PI) / dif);
    
    tmp._x2 = tmp._x1 + l * cos(PI*(quart * dif)/ 180);
    tmp._y2 = tmp._y1 + l * sin(PI*(quart * dif)/ 180);
    
    line(tmp._x1, tmp._y1, tmp._x2, tmp._y2);

  }
  if(ClickCount == 2)
  {
    navList.add(new Navigator(tmp._x1, tmp._y1, tmp._x2, tmp._y2));
    
    ClickCount = 0;
  }
  
  for (int i = 0; i < navList.size(); i++) {
    Navigator nav = navList.get(i);
    nav.show();
  }
}

int ClickCount = 0;

void mousePressed() {
  ClickCount++;
}
