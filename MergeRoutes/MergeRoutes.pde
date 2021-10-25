// Программа, проверяющая 
// принадлежность отрезков одной прямой
//
// 11.08.2021

boolean mouseChecker(float _x, float _y, int _r)
{
  boolean _flag = false;

  if ((_x - _r <= mouseX && mouseX <= _x + _r) && 
    (_y - _r <= mouseY && mouseY <= _y + _r))
  {
    _flag = true;
  }

  return _flag;
}

// Класс для хранения координат
class Point {
  public float _x;
  public float _y;

  Point() {
    this._x = 0;
    this._y = 0;
  }

  // Конструктор от двух координат
  Point(float x, float y) {
    this._x = x;
    this._y = y;
  }
}

// Класс участка маршрута
class Navigator {
  public float _x1;
  public float _y1;
  public float _x2;
  public float _y2;
  private int _r = 10;

  // Пустой конструктор
  Navigator() {
    this._x1 = 0;
    this._y1 = 0;
    this._x2 = 0;
    this._y2 = 0;
  }

  // Конструктор копирования
  Navigator(float x1, float y1, float x2, float y2) {
    this._x1 = x1;
    this._y1 = y1;
    this._x2 = x2;
    this._y2 = y2;
  }

  // Отобажение отрезка с его концами
  void show(color col) {
    line(_x1, _y1, _x2, _y2);

    fill(col);
    ellipse(_x1, _y1, _r, _r);
    ellipse(_x2, _y2, _r, _r);
    checkMouse(col);
  }

  // Реагирование на наведение мыши
  void checkMouse(color col) {
    // Проверка на наведение на первый конец отрезка
    if (mouseChecker(this._x1, this._y1, this._r) == true)
    {
      fill(#FF0000);
      ellipse(_x1, _y1, _r, _r);
    } else
    {
      fill(col);
      ellipse(_x1, _y1, _r, _r);
    }

    // Проверка на наведение на второй конец отрезка
    if (mouseChecker(this._x2, this._y2, this._r) == true)
    {
      fill(#FF0000);
      ellipse(_x2, _y2, _r, _r);
    } else
    {
      fill(col);
      ellipse(_x2, _y2, _r, _r);
    }
  }
};

// Класс для описания дороги
class Route {
  public color _color;
  public ArrayList<Navigator> _pRoute;

  Route(color _col)
  {
    this._color = _col;
    _pRoute = new ArrayList<Navigator>();
  }
};

// Функция проверки наведения мыши на конец отрезка
int isCursor(Navigator tmp) {
  int res = -1;

  if ((mouseChecker(tmp._x1, tmp._y1, tmp._r) == true))
  {
    res = 1;
  }
  else if ((mouseChecker(tmp._x2, tmp._y2, tmp._r) == true))
  {
    res = 2;
  }

  return res;
}


float dif = 9;
boolean isRoute = false;
float t_x;
float t_y;
int ClickCount = 0;
int qRoute = 0;

ArrayList<Route> routeList = new ArrayList<Route>();
ArrayList<Navigator> navList = new ArrayList<Navigator>();

Navigator tmp = new Navigator();

// Инициализация перед запуском
void setup() {
  size(800, 800);
  background(#FFFFFF);

  routeList.add(new Route(#0057FF));
  routeList.add(new Route(#FFD500));
  routeList.add(new Route(#FF00DE));

  routeList.get(0)._pRoute.add(new Navigator(400, 400, 700, 600));
  routeList.get(1)._pRoute.add(new Navigator(50, 50, 200, 200));
  routeList.get(2)._pRoute.add(new Navigator(20, 700, 400, 600));
}

// Добавление нового отрезка
void addPart()
{
  if (ClickCount == 0)
  {
    tmp._x1 = mouseX;
    tmp._y1 = mouseY;
  }
  if (ClickCount == 1)
  {
    tmp._x2 = mouseX;
    tmp._y2 = mouseY;

    float l = sqrt(pow((tmp._x1 - mouseX), 2) + pow((tmp._y1 - mouseY), 2));
    float quart = int((atan2((mouseY - tmp._y1 ), (mouseX - tmp._x1)) * 180 / PI) / dif);

    tmp._x2 = tmp._x1 + l * cos(PI*(quart * dif)/ 180);
    tmp._y2 = tmp._y1 + l * sin(PI*(quart * dif)/ 180);

    line(tmp._x1, tmp._y1, tmp._x2, tmp._y2);
  }
  if (ClickCount == 2)
  {
    if(isRoute == false)
    {
      navList.add(new Navigator(tmp._x1, tmp._y1, tmp._x2, tmp._y2));
    }
    else
    {
      routeList.get(qRoute)._pRoute.add(new Navigator(tmp._x1, tmp._y1, tmp._x2, tmp._y2));
      println("added Route");
      isRoute = false;
    }
    

    ClickCount = 0;
  }
}

// Главный Цикл отрисовки
void draw() {
  background(#FFFFFF);

  addPart();

  for (int i = 0; i < navList.size(); i++) {
    Navigator nav = navList.get(i);
    nav.show(#00FF0A);
  }

  for (int i = 0; i < routeList.size(); i++) {
    for (int j = 0; j < routeList.get(i)._pRoute.size(); j++) {
      routeList.get(i)._pRoute.get(j).show(routeList.get(i)._color);
      
      int end = isCursor(routeList.get(i)._pRoute.get(j));

      if (end == 1 && mousePressed)
      {
        ClickCount = 1;

        float _tx = routeList.get(i)._pRoute.get(j)._x1;
        float _ty = routeList.get(i)._pRoute.get(j)._y1;

        tmp._x1 = _tx;
        tmp._y1 = _ty;
        qRoute = i;
        isRoute = true;
      }
      if (end == 2 && mousePressed)
      {
        ClickCount = 1;

        float _tx = routeList.get(i)._pRoute.get(j)._x2;
        float _ty = routeList.get(i)._pRoute.get(j)._y2;

        tmp._x1 = _tx;
        tmp._y1 = _ty;
        qRoute = i;
        isRoute = true;
      }
      else if(isRoute == false)
      {
        qRoute = -1;
      }
    }
  }
}

// Счётчик кликов мыши
void mousePressed() {
  ClickCount++;
}
