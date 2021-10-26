// Выходной файл
PrintWriter output;

// Размер клетки
int cell = 25;

// Координаты клетки
float cx;
float cy;

// id сохраняемого агента
int id = 0;

// Временные строки для вывода
String tmp_str = "";
String tmp_s2 = "";

int pointCount = 0;
int lim = 3;

class Point
{
  float _x;
  float _y;
  
  Point(float x, float y)
  {
    _x = x;
    _y = y;
  }
};

void setup()
{
  size(800,800);
  stroke(20);
  background(#FFFFFF);
  
  output = createWriter("data.txt"); 
  output.println(15);
}

ArrayList<Point> particles = new ArrayList<Point>();

void draw()
{
  background(#FFFFFF);
  
  // Раки окна
  line(1, 1, 799, 1);
  line(1, 1, 1, 799);
  line(1,799, 799, 799);
  line(799, 1,799, 799);
  
  println(particles.size());
  
  for (int i = 0; i < particles.size(); i += 2) {
    float x_c  = particles.get(i)._x;
    float y_c = particles.get(i)._y;
    float x_n  = particles.get(i + 1)._x;
    float y_n = particles.get(i + 1)._y;
    
    line(x_c, y_c, x_n, y_n);
    
    ellipse(x_c, y_c, 5, 5);
    ellipse(x_n, y_n, 5, 5);
    
    textSize(25);
    text(str(i / 8), x_n, y_n);
  }

  // Координаты в клетки
  cx = cell * (mouseX / cell);
  cy = cell * (mouseY / cell);
  
  // Указатель мыши
  fill(#51FF08);
  ellipse(cx,  cy, 10, 10);
}

float x0;
float y0;

void mousePressed()
{
  if(id < 15)
  {
    // Начальные координаты агента
    if(pointCount == 0)
    {
      x0 = cx;
      y0 = cy;
    }
    
    if(pointCount <= lim)
    {
      tmp_s2 += str(x0) + " " + str(y0) + " ";
      tmp_s2 += str(cx) + " " + str(cy) + " ";
      pointCount++;
      
      particles.add(new Point(x0, y0));
      particles.add(new Point(cx, cy));

    }
    else
    {
      tmp_str = str(id) + " " + str(lim) + " " + tmp_s2;
      
      output.println(tmp_str);
      id++;
      tmp_str = "";
      tmp_s2 = "";
      pointCount = 0;
    }
  }
  else
  {
    // Сохранение скриншота
    saveFrame("image.png");
    
    // Закрытие файла
    output.close();
    
    // Закрытие программы
    exit();
  }
}