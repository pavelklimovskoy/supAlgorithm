// Проверка нахождения двух отрезков на одной прямой
// 19.08.2021

// Класс для хранения отрезка
class Seqment
{
  float _x1;
  float _y1;
  float _x2;
  float _y2;
  
  // Конструктор от координат начала и конца 
  Seqment(float x1, float y1, float x2, float y2)
  {
    this._x1 = x1;
    this._y1 = y1;
    this._x2 = x2;
    this._y2 = y2;
  }
  
  // Метод для отображения отрезка
  void show()
  {
    line(_x1, _y1, _x2, _y2);
    ellipse(_x1, _y1, 5, 5);
    ellipse(_x2, _y2, 5, 5);
  }
};

// Тестовые отрезки
Seqment s1 = new Seqment(300, 300, 500, 500);
Seqment s2 = new Seqment(600, 600, 700, 700);

// Проверка нахождения двух отрезков на одной прямой
void check(Seqment s1, Seqment s2)
{
   float p1_x = (s2._x1 - s1._x1) / (s1._x2 - s1._x1);
   float p1_y = (s2._y1 - s1._y1) / (s1._y2 - s1._y1);
   float p2_x = (s2._x2 - s1._x1) / (s1._x2 - s1._x1);
   float p2_y = (s2._y2 - s1._y1) / (s1._y2 - s1._y1);
  
  if ((p1_x == p1_y) && (p2_x == p2_y))
  {
    println("YES");
  }
}

// Задание цвета фона и размера окна
void setup()
{
  background(#FFFFFF);
  size(800, 800);
}

// Главный рабочий цикл
void draw()
{
  background(#FFFFFF);
  
  s1.show();
  s2.show();
  
  s2._x2  = mouseX;
  s2._y2  = mouseY;
  
  check(s1, s2);
  
  
}
