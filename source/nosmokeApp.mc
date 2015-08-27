using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Application as App;



var kippen, max_kippen, last_update, today, total;
enum{
  KIPPEN,
  MAX_KIPPEN, 
  LAST_UPDATE,
  TOTAL
}

class nosmokeApp extends App.AppBase {

    //! onStart() is called on application start up
    function onStart() {
        var last_update;
        var dateStrings = Time.Gregorian.info( Time.now(), Time.FORMAT_SHORT);
        var day,month,year;
        day    = dateStrings.day;
        month  = dateStrings.month;
        year   = dateStrings.year; 
        
         var app = App.getApp();
         kippen = app.getProperty(KIPPEN);
         total = app.getProperty(TOTAL);
         max_kippen = app.getProperty(MAX_KIPPEN);
         if (kippen == null) {kippen = 999;}
         if (total == null) {total = 0;}         
         if (max_kippen == null) {max_kippen = 999;}
         last_update = app.getProperty(LAST_UPDATE);
         if (last_update == null) {last_update = 999;}
          today =  sec_calc({ 
                :year   => year.toNumber(),
                :month  => month.toNumber(),
                :day    => day.toNumber(),
                :hour   => 00,
                :minute => 00,
                :second => 01
                });
                         
         if (kippen != max_kippen){
            if (today.toNumber() > last_update.toNumber()){
               app.setProperty(LAST_UPDATE, today);
               kippen = max_kippen;
            }
         }
         kippen = kippen.toNumber();
         max_kippen = max_kippen.toNumber();
         total = total.toNumber();
         
          
    }

    //! onStop() is called when your application is exiting
    function onStop() {
        var app = App.getApp();
        app.setProperty(KIPPEN, kippen.toString());
        app.setProperty(TOTAL, total.toString());
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new nosmokeView(), new nosmokeViewDelegate()  ];
    }


    function sec_calc(params){
        var secs = Gregorian.moment(params);
        secs = secs.value();
        return secs;
    }


}