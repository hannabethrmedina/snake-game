class Button {
  boolean isMouseOver;
  boolean isMousePressed;
  color selected;
  color unselected;
  int x,y,w,h;
  
  Button(int _x, int _y, int _w, int _h, color _selected, color _unselected) {
    selected = _selected;
    unselected = _unselected;
    isMouseOver = false;
    isMousePressed = false;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
  }
  
  void update(int mx, int my) {
    if (mx > x - w/2 && mx < x+w/2 && my > y-h/2 && my < y+h/2) {
      isMouseOver = true;
    } else {
      isMouseOver = false;
    }
  }
  
  
  void display() {
    if (isMouseOver) {
      fill(selected);
    } else {
      fill(unselected);
    }
    drawButton();
  }
  
  void drawButton() {
    stroke(0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  boolean isPressed() {
    if (isMouseOver) {
      isMousePressed = true;
      return true;
    }
    return false;
  }
  
  boolean isReleased() {
    isMousePressed = false;
    return false;
  }
}
