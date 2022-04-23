// объявление глобальных переменных
Sprite bob;

PImage grass_block;
PImage box_block;
PImage red_block;
PImage brown_block;
ArrayList<Sprite> platforms;

final static float SPRITE_SIZE = 50;
final static float SPRITE_SCALE = SPRITE_SIZE/128;
final static float MOVE_SPEED = 2;
final static float GRAVITY = 0.5;

// функция инициализации
void setup(){
  // задаем размер окна приложения
  size(800, 600);
  imageMode(CENTER);
  bob = new Sprite("src/bob.png", 80, 300, 0.7);
  bob.set_step_x(0);
  bob.set_step_y(0);
  
  box_block = loadImage("src/box_block.png");
  grass_block = loadImage("src/grass_dirt_block.png");
  red_block = loadImage("src/red_block.png");
  brown_block = loadImage("src/brown_block.png");
  platforms = new ArrayList<Sprite>();
  createPlatforms("src/map.csv");
}

// функция отрисовки
void draw(){
  background(255, 255, 255);
  
  bob.show();
  resolvePlatformCollisions(bob, platforms);
  
  for(Sprite s: platforms)
    s.show();
}

void keyPressed(){
  if(keyCode == RIGHT){
    bob.set_step_x(MOVE_SPEED);
  } else if (keyCode == LEFT){
    bob.set_step_x(-MOVE_SPEED);
  } else if (keyCode == UP){
    bob.set_step_y(-MOVE_SPEED);
  } else if (keyCode == DOWN){
    bob.set_step_y(MOVE_SPEED);
  }
}

void keyReleased(){
    if(keyCode == RIGHT){
    bob.set_step_x(0);
  } else if (keyCode == LEFT){
    bob.set_step_x(0);
  } else if (keyCode == UP){
    bob.set_step_y(0);
  } else if (keyCode == DOWN){
    bob.set_step_y(0);
  }
}

void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
    for(int row = 0; row < lines.length; row++){
    String[] cells = split(lines[row], ",");
    for(int col = 0; col < cells.length; col++){
      if(cells[col].equals("1")){
        Sprite sprite = new Sprite(box_block, SPRITE_SCALE);
        sprite.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sprite.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sprite);
      }
      else if(cells[col].equals("2")){
        Sprite sprite = new Sprite(grass_block, SPRITE_SCALE);
        sprite.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sprite.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sprite);
      }
      else if(cells[col].equals("3")){
        Sprite sprite = new Sprite(brown_block, SPRITE_SCALE);
        sprite.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sprite.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sprite);
      }
      else if(cells[col].equals("4")){
        Sprite sprite = new Sprite(red_block, SPRITE_SCALE);
        sprite.set_position_x(SPRITE_SIZE/2 + col * SPRITE_SIZE);
        sprite.set_position_y(SPRITE_SIZE/2 + row * SPRITE_SIZE);
        platforms.add(sprite);
      }
    }
  }
}

boolean checkCollision(Sprite sprite1, Sprite sprite2){
  boolean noXCross = sprite1.getRight() <= sprite2.getLeft() || sprite1.getLeft() >= sprite2.getRight();
  boolean noYCross = sprite1.getBottom() <= sprite2.getTop() || sprite1.getTop() >= sprite2.getBottom();
  if(noXCross || noYCross){
    return false;
  } else{
    return true;
  }   
}

public ArrayList<Sprite> checkCollisionsList(Sprite sprite, ArrayList<Sprite> list){
  ArrayList<Sprite> collisions_list = new ArrayList<Sprite>();
  for(Sprite s: list){
    if (checkCollision(sprite, s)){
          collisions_list.add(s);
    }
  }
  return collisions_list;
}

// метод для обработки коллизий связанных с платформами
public void resolvePlatformCollisions(Sprite sprite, ArrayList<Sprite> platfs){

  sprite.set_step_y(sprite.get_step_y() + GRAVITY);
  
  sprite.set_position_y(sprite.get_position_y() + sprite.get_step_y());
  ArrayList<Sprite> collisions_list = checkCollisionsList(sprite, platfs);
  
  if(collisions_list.size() > 0){
    Sprite collided = collisions_list.get(0);
    if(sprite.get_step_y() > 0){
      sprite.setBottom(collided.getTop());
    } else if(sprite.get_step_y() < 0){
      sprite.setTop(collided.getBottom());
    }
    sprite.set_step_y(0);
  }
  
  sprite.set_position_x(sprite.get_position_x() + sprite.get_step_x());
  collisions_list = checkCollisionsList(sprite, platfs);
  
  if(collisions_list.size() > 0){
    Sprite collided = collisions_list.get(0);
    if(sprite.get_step_x() > 0){
      sprite.setRight(collided.getLeft());
    } else if(sprite.get_step_x() < 0){
      sprite.setLeft(collided.getRight());
    }
  }
}
