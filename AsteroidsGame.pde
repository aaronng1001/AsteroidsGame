stars [] bunch;
ArrayList <Asteroid> asteroids;
ArrayList <Bullet> ball;
SpaceShip plzWork;
boolean forward, backwards, left, right, slowDown, shoot, gameOver;
int shootTime = -500;

//----------------------------------------------------setup----------------------------------------------------

public void setup() 
{
  size (1920, 1080);
  background (0);
  plzWork = new SpaceShip();
  bunch = new stars [500];
  for (int i = 0; i < bunch.length; i++)
    bunch [i] = new stars();
  asteroids = new ArrayList<Asteroid>();
  for (int a = 0; a < 30; a++)
    asteroids.add (new Asteroid());
  ball = new ArrayList<Bullet>();
}

//----------------------------------------------------draw----------------------------------------------------

public void draw() 
{
  System.out.println(frameRate);
  background(0);
  for (int i = 0; i <bunch.length; i++)
    bunch[i].show();
  for (int b = 0; b < ball.size(); b++)
  {
    ball.get(b).move();
    ball.get(b).show();
  }
  for (int a = 0; a < asteroids.size(); a++)
  {
    asteroids.get(a).move();
    asteroids.get(a).show();
  }
  crashAndRemove();
  control();
  plzWork.show();
  plzWork.move();
  }


//----------------------------------------------------crashing and bullets----------------------------------------------------

public void crashAndRemove()
{
  for (int a = asteroids.size()-1; a >= 0; a--) {
    for (int b = ball.size()-1; b >= 0; b--){
    int closeXbullet = (int)(ball.get(b).myCenterX-asteroids.get(a).myCenterX);
    int closeYbullet = (int)(ball.get(b).myCenterY-asteroids.get(a).myCenterY);
    if (abs(closeXbullet)<25 && abs(closeYbullet)<25){
      asteroids.remove(a);
      ball.remove(b);
    }
    }
  }
  for (int c = 0; c < asteroids.size(); c++) {
    int closeXship = (int)(plzWork.myCenterX-asteroids.get(c).myCenterX);
    int closeYship = (int)(plzWork.myCenterY-asteroids.get(c).myCenterY);
    if (abs(closeXship)<30 && abs(closeYship)<30 && (plzWork.myDirectionX > 0 || plzWork.myDirectionY > 0 || plzWork.myDirectionX < 0 || plzWork.myDirectionY < 0 || plzWork.myPointDirection < 0 || plzWork.myPointDirection > 0 )){
    background(0);
    textSize(40);
    text("game over", 1920/2, 1080/2);
    fill(0, 102, 153, 51);
    noLoop();
    }
}
for (int d = ball.size()-1; d >= 0; d--){
if (millis() - ball.get(d).time>1000)
    ball.remove(d);
}
}
//----------------------------------------------------controlls----------------------------------------------------


public void keyPressed()
{
  if (key == 'w')
    forward = true;
  if (key == 's')
    backwards = true;
  if (key == 'a')
    left = true;
  if (key == 'd')
    right = true;
  if (key == 'q')
  {
    plzWork.setX((int)(Math.random()*1740+90));
    plzWork.setY((int)(Math.random()*900+90));
    plzWork.setDirectionX(0);
    plzWork.setDirectionY(0);
  }
  if (keyCode == SHIFT)
    slowDown = true;
  if (keyCode == ' ')
    shoot = true;
}
public void keyReleased()
{
  if (key == 'w')
    forward = false;
  if (key == 's')
    backwards = false;
  if (key == 'a')
    left = false;
  if (key == 'd')
    right = false;
  if (keyCode == SHIFT)
    slowDown = false;
  if (keyCode == ' ')
    shoot = false;
}
public void control()
{
  if (forward == true && backwards == true)
    plzWork.accelerate(-.05);
  else if (forward==true)
    plzWork.accelerate(.15);
  else if (backwards==true)
    plzWork.accelerate(-.15);
  if (left == true && right == true)
    plzWork.rotate(0);
  if (left == true)
    plzWork.rotate(-5);
  if (right == true)
    plzWork.rotate(5);
  if (slowDown == true)
  {
    if (plzWork.myDirectionX>0 || plzWork.myDirectionX<0)
      plzWork.setDirectionX(plzWork.getDirectionX()*.95);
    if (plzWork.myDirectionY>0 || plzWork.myDirectionY<0)
      plzWork.setDirectionY(plzWork.getDirectionY()*.95);
  }
  if (shoot == true && millis()-shootTime>500)
  {
  shootTime=millis();
  ball.add(new Bullet());
  }
}

//----------------------------------------------------asteroids----------------------------------------------------

class Asteroid extends Floater
{
  int rotSpeed; 
  Asteroid()
  {
    corners = 17;
    xCorners = new int[]{-28, -32, -24, -20, -8, 0, 8, 16, 20, 20, 24, 20, 12, 4, -8, -16, -24, };
    yCorners = new int[]{8, 0, -8, -16, -24, -20, -16, -16, -8, -4, 8, 20, 16, 24, 28, 20, 20};
    myColor = color(46, 118, 118);
    myCenterX = ((int)(Math.random()*1740+90));
    myCenterY = ((int)(Math.random()*900+90));
    myDirectionX = ((int)(Math.random()*6)-3);
    myDirectionY = ((int)(Math.random()*6)-3);
    myPointDirection = 0;
    rotSpeed = ((int)(Math.random()*7)-3);
    while (myDirectionX == 0 && myDirectionY == 0)
    {
      myDirectionX = ((int)(Math.random()*6)-3);
      myDirectionY = ((int)(Math.random()*6)-3);
    }
  }
  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
  public void setX(int x) {
    myCenterX = x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY = y;
  }
  public int getY() {
    return (int)myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX = x;
  }
  public double getDirectionX() {
    return myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY =y;
  }
  public double getDirectionY() {
    return myDirectionY;
  }
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }
  public double getPointDirection() {
    return myPointDirection;
  }
}

//----------------------------------------------------spaceship----------------------------------------------------

class SpaceShip extends Floater  
{   
  SpaceShip()
  {
    corners = 4;
    xCorners = new int[]{-16, 32, -16, -4};
    yCorners = new int[]{-16, 0, 16, 0};
    myColor = color(60, 29, 242);
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x) {
    myCenterX = x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY = y;
  }
  public int getY() {
    return (int)myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX = x;
  }
  public double getDirectionX() {
    return myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY =y;
  }
  public double getDirectionY() {
    return myDirectionY;
  }
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }
  public double getPointDirection() {
    return myPointDirection;
  }
}

//----------------------------------------------------bullets----------------------------------------------------

class Bullet extends Floater  
{   
  int time;
  Bullet()
  {
    corners = 4;
    xCorners = new int[]{-16, 32, -16, -4};
    yCorners = new int[]{-16, 0, 16, 0};
    myColor = color(60, 29, 242);
    myPointDirection = plzWork.myPointDirection;
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 10 * Math.cos(dRadians) + plzWork.myDirectionX;
    myDirectionY = 10 * Math.sin(dRadians) + plzWork.myDirectionY;
    myCenterX = plzWork.myCenterX + 32 * Math.cos(dRadians);
    myCenterY = plzWork.myCenterY + 32 * Math.sin(dRadians);
    time = millis();
  }
  public void show()
  {
  fill(255,0,0);
  noStroke();
  ellipse((float)myCenterX,(float)myCenterY,(float)5,(float)5);
  }
  public void setX(int x) {
    myCenterX = x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY = y;
  }
  public int getY() {
    return (int)myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX = x;
  }
  public double getDirectionX() {
    return myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY =y;
  }
  public double getDirectionY() {
    return myDirectionY;
  }
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }
  public double getPointDirection() {
    return myPointDirection;
  }
}

//----------------------------------------------------stars----------------------------------------------------
class stars
{
  int starX, starY;
  stars() {
    starX = ((int)(Math.random()*1920));
    starY = ((int)(Math.random()*1080));
  }
  public void show()
  {
    fill(255);
    noStroke();
    ellipse(starX, starY, 3, 3);
  }
}

//----------------------------------------------------floater----------------------------------------------------


abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if (myCenterX >width)
    {     
      myCenterX = 0;
    } else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if (myCenterY >height)
    {    
      myCenterY = 0;
    } else if (myCenterY < 0)
    {     
      myCenterY = height;
    }
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
} 
