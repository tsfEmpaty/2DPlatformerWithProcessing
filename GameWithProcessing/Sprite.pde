public class Sprite {
  private PImage img;
  private float position_x;
  private float position_y;
  private float step_x;
  private float step_y;
  private float s_width;
  private float s_height;

  public Sprite(String filename, float p_x, float p_y, float scale) {
    img = loadImage(filename);
    position_x = p_x;
    position_y = p_y;
    step_x = 0;
    step_y = 0;
    s_width = img.width * scale;
    s_height = img.height * scale;
  }
  
  public Sprite(PImage image, float scale) {
    img = image;
    position_x = 0;
    position_y = 0;
    step_x = 0;
    step_y = 0;
    s_width = img.width * scale;
    s_height = img.height * scale;
  }
  
  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }

  public void set_step_x(float step) {
    step_x = step;
  }

  public void set_step_y(float step) {
    step_y = step;
  }
  
  public void set_position_x(float position){
    position_x = position;
  }
  
  public void set_position_y(float position){
    position_y = position;
  }
  
  public float get_step_x(){
    return step_x;
  }
  
  public float get_step_y(){
    return step_y;
  }
  
  public float get_position_x(){
    return position_x;
  }
  
  public float get_position_y(){
    return position_y;
  }

  public void show() {
    image(img, position_x, position_y, s_width, s_height);
  }
  
  public void update_position(){
    position_x += step_x;
    position_y += step_y;
  }
  
  public void setTop(float top){
    position_y = top + s_height / 2;
  }
  
  public void setBottom(float bottom){
    position_y = bottom - s_height / 2;
  }
  
  public void setRight(float right){
    position_x = right - s_width / 2;
  }
  
  public void setLeft(float left){
    position_x = left + s_width / 2;
  }  
  
  public float getTop(){
    return position_y - s_width / 2;
  }
  
  public float getBottom(){
    return position_y + s_width / 2;
  }
  
  public float getRight(){
    return position_x + s_width / 2;
  }
  
  public float getLeft(){
    return position_x - s_width / 2;
  }
}
