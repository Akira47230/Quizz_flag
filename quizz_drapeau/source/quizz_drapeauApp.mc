// source/quizz_drapeauApp.mc - Version corrigée
import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class quizz_drapeauApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new quizz_drapeauView();
        var delegate = new quizz_drapeauDelegate(view);
        return [ view, delegate ];
    }
}

function getApp() as quizz_drapeauApp {
    return Application.getApp() as quizz_drapeauApp;
}