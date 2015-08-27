using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Application as App;
using Toybox.Math as Math;

var xpos = 135;
var changed;
var testVali = 20;// standard Wert

//class NPDi extends Ui.NumberPickerDelegate {
//    function onNumberPicked(value) {
//        if (value.toNumber() == null || value.toNumber() > 100 ) {value = 1;} 
//        max_kippen = value.toNumber();
//        var app = App.getApp();
//        app.setProperty(MAX_KIPPEN, kippen.toString());
//        kippen = max_kippen;        
//    }
//}

class KeyboardListener_y extends Ui.TextPickerDelegate {
    function onTextEntered(text, changed) {
        if (changed) {max_kippen = text;} else {max_kippen = "10";}
        var app = App.getApp();
        app.setProperty(MAX_KIPPEN, max_kippen.toString());
        kippen = max_kippen.toNumber();        
        
    }
}

class CD extends Ui.ConfirmationDelegate {
var returnVal;
    function onResponse(value) {
        if( value == 0 ) {
            returnVal = "Cancel/No";
            Ui.requestUpdate();            
        }
        else {
            returnVal = "Confirm/Yes";
            App.getApp().clearProperties();
            kippen      = 999;
            last_update = 999;
            max_kippen  = 999;
            Ui.requestUpdate();
        }
    }
}

class nosmokeView extends Ui.View {

    //! Load your resources here
    function onLayout(dc) {
        
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
       dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK); 
       dc.fillRectangle(0,0 , dc.getWidth(), dc.getHeight());
       dc.clear();
       
       if (kippen == 999){
           dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
           dc.drawText(dc.getWidth()/2, 90, Gfx.FONT_MEDIUM, "PUSH+HOLD menu", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.drawText(dc.getWidth()/2-1, 90, Gfx.FONT_MEDIUM, "PUSH+HOLD menu", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.drawText(dc.getWidth()/2+1, 90, Gfx.FONT_MEDIUM, "PUSH+HOLD menu", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.drawText(dc.getWidth()/2, 120, Gfx.FONT_MEDIUM, "to SET daily", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.drawText(dc.getWidth()/2, 150, Gfx.FONT_MEDIUM, "cigs", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.fillPolygon([[0,109],[18,99],[19,119]]);
           
            
       }else{
	       dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_ORANGE); 
	       dc.fillRectangle(10, 109, 43, 18);  // Filter
	       dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_YELLOW);
	       dc.fillEllipse(15, 112, 2, 1);
	       dc.fillEllipse(22, 120, 3, 2);
	       dc.fillEllipse(34, 123, 2, 2);
	       dc.fillEllipse(40, 114, 4, 2);
	       dc.fillEllipse(46, 122, 2, 3);

	       dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY); 
	       dc.fillRectangle(53, 109, 2, 18);  // Zwischen Filter und Kippe
	       dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE); 
	       
	       var xlen = 135 * kippen.toFloat()/max_kippen.toFloat();	  
	       if (xlen <= 0) {xlen = 0;}     
	       dc.fillRectangle(55, 109, xlen, 18);  //KIPPE an sich
	       dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_LT_GRAY); 
	       draw_glut(dc,55+xlen-5,109);

	       if (kippen.toFloat() <= 0){
               dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED);
               dc.setPenWidth(10);
               dc.drawCircle(109, 109, 100);
               dc.drawLine(10,208,208,10);
               dc.setPenWidth(1);
           }
           // SCHRIFT

           dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);        
           dc.drawText(dc.getWidth()/2, 60, Gfx.FONT_NUMBER_THAI_HOT, kippen.toString(), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.drawText(dc.getWidth()/2+2, 60, Gfx.FONT_NUMBER_THAI_HOT, kippen.toString(), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
           dc.drawText(dc.getWidth()/2-2, 60, Gfx.FONT_NUMBER_THAI_HOT, kippen.toString(), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); 
           dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
           dc.drawText(dc.getWidth()/2, 170, Gfx.FONT_MEDIUM, "Total:", Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); 
           dc.drawText(dc.getWidth()/2, 200, Gfx.FONT_LARGE, total.toString(), Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER); 
           
	   }     
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }
    
    function draw_glut(dc,x,y){
       if (kippen.toNumber() != max_kippen.toNumber() ){
        dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_DK_RED);
        dc.fillRoundedRectangle(x, y, 10, 18, 2);      
          
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY);
       if (kippen.toNumber() > 0){
	        for (var i = 0; i < 5; i++ ){
	            var j = i % 3;
	            if (j == 0){dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_LT_GRAY);}
	            if (j == 1){dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY);}
	            if (j == 2){dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);}
	            dc.fillCircle(x+7+(i*12), (y-10-i*18), (8+i*6));
	        }
        }
             
       // dc.fillPolygon([[x,(y-8)],[(x-10),(y-18)],[x,(y-28)],[(x-12),(y-48)],[(x-10),(y-25)],[(x+3),(y-25)],[(x-9),(y-18)],[(x+3),(y-5)]]);  
       } 
    }

}
class nosmokeViewDelegate extends Ui.BehaviorDelegate {
    function onKey(key) {
           //Sys.println(key.getKey()); 
           if(key.getKey() == Ui.KEY_MENU) {
            
            if (kippen != 999){ 
             var cd;
             cd = new Ui.Confirmation( "Reset max cigs?" );
             Ui.pushView( cd, new CD(), Ui.SLIDE_IMMEDIATE );
            }else{
	            testVali = 20;
	            var np;
	            Ui.pushView(new Ui.TextPicker("10"), new KeyboardListener_y(), Ui.SLIDE_DOWN );
            }
           }
           if(key.getKey() == Ui.KEY_ENTER) {
                Ui.requestUpdate();
                kippen = kippen.toNumber() - 1;
                total = total.toNumber() + 1;
               // Sys.println("ENTER gedrueckt");
       } 
    }
}