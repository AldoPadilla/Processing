
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;

import com.temboo.core.*;
import com.temboo.Library.Google.Spreadsheets.*;

// Create a session using your Temboo account application details
TembooSession session = new TembooSession("aldopadilla", "myFirstApp", "a3c4a3959e8b4d139495c154d3d406e0");

private Random random = new Random();

DeviceRegistry registry;

class TestObserver implements Observer {
  public boolean hasStrips = false;
  public void update(Observable registry, Object updatedDevice) {
        println("Registry changed!");
        if (updatedDevice != null) {
          println("Device change: " + updatedDevice);
        }
        this.hasStrips = true;
    }
}

TestObserver testObserver;

int r = 0;
int g = 0;
int b = 0;

void setup() {
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  
  colorMode(RGB, 255);
  size(640, 640); 
  
    runRetrieveLastColumnValueChoreo(); 
  

}


//
//Put things here
//
void runRetrieveLastColumnValueChoreo() {

  
RetrieveLastColumnValue retrieveLastColumnValueChoreo = new RetrieveLastColumnValue(session);

  // Set inputs
  retrieveLastColumnValueChoreo.setWorksheetName("Sheet1");
  retrieveLastColumnValueChoreo.setUsername("TEDXRVABCTEAM@gmail.com");
  retrieveLastColumnValueChoreo.setPassword("Brandcenter");
  retrieveLastColumnValueChoreo.setColumnName("education");
  retrieveLastColumnValueChoreo.setSpreadsheetName("fromboothtocloud");
  retrieveLastColumnValueChoreo.setSpreadsheetKey("0ApBn_vvizbiNdGswQU9NRFYwVXliZ09BTnA1WTBuYlE");

  // Run the Choreo and store the results
  RetrieveLastColumnValueResultSet retrieveLastColumnValueResultsR = retrieveLastColumnValueChoreo.run();
    r = Integer.parseInt(retrieveLastColumnValueResultsR.getCellValue());

    // Set inputs
    retrieveLastColumnValueChoreo.setColumnName("art");
  
  // Run the Choreo and store the results
  RetrieveLastColumnValueResultSet retrieveLastColumnValueResultsG = retrieveLastColumnValueChoreo.run();
  
  
  g = Integer.parseInt(retrieveLastColumnValueResultsG.getCellValue());
  
      // Set inputs
    retrieveLastColumnValueChoreo.setColumnName("philantrophy");

  // Run the Choreo and store the results
  RetrieveLastColumnValueResultSet retrieveLastColumnValueResultsB = retrieveLastColumnValueChoreo.run();
  
  
  b = Integer.parseInt(retrieveLastColumnValueResultsB.getCellValue());
  
  println(r,g,b);
  
  
}

void draw() {
  
  background(r,g,b);
  
  if (testObserver.hasStrips) {
    registry.startPushing();
    registry.setAutoThrottle(true);
    int stripy = 0;
    List<Strip> strips = registry.getStrips();
    
    if (strips.size() > 0) {
      int yscale = height / strips.size();
      for(Strip strip : strips) {
        int xscale = width / strip.getLength();
        for (int stripx = 0; stripx < strip.getLength();
        stripx++) {
          color c = get(stripx*xscale, stripy*yscale);
          
          strip.setPixel(c, stripx);
        }
        stripy++;
      }
    }
  }
  runRetrieveLastColumnValueChoreo(); //THIS IS WHAT MAKES IT LOOP BITCHES
  delay(10000); //Currently set to ten seconds0
}


