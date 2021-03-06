// Class for creates the pinball  //<>// //<>//

class Pinball {

  Body body;
  float rad;
  boolean active;
  color col;

  Pinball(float x, float y, float r) {
    rad = r;
    makeBody(x, y, r);
    body.setUserData(this); //for collision detect
    col = color(255, 0, 0);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  //destroys ball when it is off the screen
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+rad*2) {
      killBody();
      return true;
    }
    return false;
  }


  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    fill(col);
    strokeWeight(1);
    stroke(0);
    rotate(a);
    ellipse(0, 0, rad*2, rad*2);
    popMatrix();
  }

  // Create the body for pinball
  void makeBody(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    bd.bullet = true; //fixes tunneling
    body = box2d.world.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(rad);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = .7;

    body.createFixture(fd);

    body.setAngularVelocity(random(-10, 10));
  }

  // Change color when hit
  void change() {
    col = color(random(0, 255), random(0, 255), random(0, 255));
  }
}
