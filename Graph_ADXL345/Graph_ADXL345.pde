/**
 * RollingGraph
 * This sketch makes ise of the RollingLine2DTrace object to
 * draw a dynamically updated plot.
 */
import processing.serial.*;

import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.traces.ILine2DEquation;
import org.gwoptics.graphics.graph2D.traces.RollingLine2DTrace;

Serial sp;
byte[] buff;
float[] m;
int OFFSET_X = -55, OFFSET_Y = -65, OFFSET_Z = -55;    //These offsets are chip specific, and vary.  Play with them to get the best ones for you


class eq implements ILine2DEquation{
    public double computePoint(double x,int pos) {
        return m[0];
    }
}

class eq2 implements ILine2DEquation{
    public double computePoint(double x,int pos) {
        return m[1];
    }
}

class eq3 implements ILine2DEquation{
public double computePoint(double x,int pos) {
        return m[2];
    }
}

RollingLine2DTrace r,r2,r3;
Graph2D g;

void setup(){
  
  String portName = Serial.list()[2];
  sp = new Serial(this, portName,  9600);
  buff = new byte[64];

  m = new float[3];


    size(900,600);

    r  = new RollingLine2DTrace(new eq() ,10,0.01f);
    r.setTraceColour(0, 255, 0);

    r2 = new RollingLine2DTrace(new eq2(),10,0.01f);
    r2.setTraceColour(255, 0, 0);

    r3 = new RollingLine2DTrace(new eq3(),10,0.01f);
    r3.setTraceColour(0, 0, 255);

    g = new Graph2D(this, 700, 500, false);
    g.setYAxisMax(1);
    g.addTrace(r);
    g.addTrace(r2);
    g.addTrace(r3);
    g.position.y = 50;
    g.position.x = 100;
    g.setYAxisTickSpacing(100);
    g.setXAxisMax(5f);
}

void draw(){
    background(255);
    g.draw();
    
        int bytes = sp.readBytesUntil((byte)10, buff);

        String mystr = (new String(buff, 0, bytes)).trim();
    if(mystr.split(" ").length != 3) {
      println(mystr);
      return;
    }
    setVals(m, mystr);
    
        float x = m[0], y = m[1],  z = m[2];
        
            println(m[0] + ", " + m[1] + ", " + m[2]);

}

void setVals(float[] m, String s) {
  int i = 0;
  m[0] = -(float)(Integer.parseInt(s.substring(0, i = s.indexOf(" "))) + OFFSET_X)*HALF_PI/256;
  m[1] = -(float)(Integer.parseInt(s.substring(i+1, i = s.indexOf(" ", i+1))) + OFFSET_Y)*HALF_PI/256;
  m[2] = (float) (Integer.parseInt(s.substring(i+1)) + OFFSET_Z)*HALF_PI/256; 
  
  
}
