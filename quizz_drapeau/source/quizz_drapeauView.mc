// source/quizz_drapeauView.mc - Version améliorée selon les demandes
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;

class quizz_drapeauView extends WatchUi.View {
    private var _quizManager as QuizManager;
    private var _gameState as Symbol; // :menu, :playing, :result, :finalScore
    private var _delegate as Object or Null;
    private var _lastResultTitle as String;
    private var _lastResultCorrect as Boolean;
    private var _resultTimer as Timer.Timer or Null;

    function initialize() {
        View.initialize();
        _quizManager = new QuizManager();
        _gameState = :menu;
        _delegate = null;
        _lastResultTitle = "";
        _lastResultCorrect = false;
        _resultTimer = null;
    }

    function setDelegate(delegate as Object) as Void {
        _delegate = delegate;
    }

    function onLayout(dc as Dc) as Void {
        // Pas de layout fixe, on dessine tout manuellement
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        switch (_gameState) {
            case :menu:
                drawMenu(dc);
                break;
            case :playing:
                drawQuestion(dc);
                break;
            case :result:
                drawResult(dc);
                break;
            case :finalScore:
                drawFinalScore(dc);
                break;
        }
    }

    function drawMenu(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY - 40, Graphics.FONT_MEDIUM, 
                   "Quiz Drapeaux", Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.drawText(centerX, centerY - 10, Graphics.FONT_SMALL, 
                   "20 questions", Graphics.TEXT_JUSTIFY_CENTER);
                   
        dc.drawText(centerX, centerY + 20, Graphics.FONT_TINY, 
                   "SELECT pour commencer", Graphics.TEXT_JUSTIFY_CENTER);
        
        // SUPPRIMÉ: "MENU pour quitter" n'est plus nécessaire
    }

    function drawQuestion(dc as Dc) as Void {
        var question = _quizManager.getCurrentQuestion();
        if (question == null) {
            return;
        }

        var width = dc.getWidth();
        var height = dc.getHeight();
        var screenCenterX = width / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // MODIFIÉ: Score sur une ligne en dessous du numéro de question
        var questionText = _quizManager.getCurrentQuestionNumber() + "/" + 
                          _quizManager.getTotalQuestions();
        dc.drawText(screenCenterX, height * 0.02, Graphics.FONT_TINY, questionText, Graphics.TEXT_JUSTIFY_CENTER);
        
        var scoreText = "Score: " + _quizManager.getScore();
        dc.drawText(screenCenterX, height * 0.08, Graphics.FONT_TINY, scoreText, Graphics.TEXT_JUSTIFY_CENTER);

        // Zone pour le drapeau - légèrement remontée
        var flagWidth = (width * 0.805).toNumber();
        var flagHeight = (height * 0.4025).toNumber();
        var flagX = screenCenterX - (flagWidth / 2);
        var flagY = (height * 0.14).toNumber();      // Remonté de 15% à 14%
        
        // Chargement et affichage du drapeau
        var flagId = question[:flag] as String;
        var flagResource = getFlagResource(flagId);
        
        if (flagResource != null) {
            try {
                var flagBitmap = WatchUi.loadResource(flagResource);
                if (flagBitmap != null) {
                    var bitmapWidth = flagBitmap.getWidth().toNumber();
                    var bitmapHeight = flagBitmap.getHeight().toNumber();
                    
                    var imgX = flagX + (flagWidth - bitmapWidth) / 2;
                    var imgY = flagY + (flagHeight - bitmapHeight) / 2;
                    
                    dc.drawBitmap(imgX, imgY, flagBitmap);
                } else {
                    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                    dc.drawText(screenCenterX, flagY + flagHeight/2, Graphics.FONT_SMALL, 
                               flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
                }
            } catch (e) {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(screenCenterX, flagY + flagHeight/2, Graphics.FONT_SMALL, 
                           flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
            }
        } else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(screenCenterX, flagY + flagHeight/2, Graphics.FONT_SMALL, 
                       flagId.toUpper(), Graphics.TEXT_JUSTIFY_CENTER);
        }

        // MODIFIÉ: Options de réponse remontées et sans numérotation
        var answers = question[:answers] as Array;
        var buttonsStartY = (height * 0.57).toNumber();  // Remonté de 60% à 57%
        var buttonHeight = (height * 0.12).toNumber();
        var buttonMargin = (width * 0.15).toNumber();
        var selectedIndex = getSelectedAnswerIndex();
        
        for (var i = 0; i < answers.size(); i++) {
            var y = buttonsStartY + (i * buttonHeight);
            var isSelected = (i == selectedIndex);
            
            var buttonColor = isSelected ? 0x1E5631 : 0x110323ff;
            var textColor = Graphics.COLOR_WHITE;
            
            dc.setColor(buttonColor, Graphics.COLOR_TRANSPARENT);
            dc.fillRoundedRectangle(buttonMargin, y, width - (2 * buttonMargin), 
                                  (buttonHeight * 0.8).toNumber(), 3);
            
            dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
            // SUPPRIMÉ: Plus de numérotation "(i + 1). "
            var answerText = answers[i] as String;
            dc.drawText(screenCenterX, y + (buttonHeight * 0.2).toNumber(), 
                       Graphics.FONT_XTINY, answerText, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    // Fonction pour mapper les IDs de drapeaux aux ressources
    private function getFlagResource(flagId as String) as ResourceId or Null {
        switch (flagId) {
            case "fr": return Rez.Drawables.fr;
            case "de": return Rez.Drawables.de;
            case "es": return Rez.Drawables.es;
            case "it": return Rez.Drawables.it;
            case "gb": return Rez.Drawables.gb;
            case "us": return Rez.Drawables.us;
            case "ca": return Rez.Drawables.ca;
            case "jp": return Rez.Drawables.jp;
            case "cn": return Rez.Drawables.cn;
            case "br": return Rez.Drawables.br;
            case "ar": return Rez.Drawables.ar;
            case "au": return Rez.Drawables.au;
            case "ru": return Rez.Drawables.ru;
            case "in": return Rez.Drawables.in;
            case "mx": return Rez.Drawables.mx;
            case "se": return Rez.Drawables.se;
            case "no": return Rez.Drawables.no;
            case "nl": return Rez.Drawables.nl;
            case "ch": return Rez.Drawables.ch;
            case "be": return Rez.Drawables.be;
            case "pt": return Rez.Drawables.pt;
            case "gr": return Rez.Drawables.gr;
            case "tr": return Rez.Drawables.tr;
            case "eg": return Rez.Drawables.eg;
            case "za": return Rez.Drawables.za;
            case "kr": return Rez.Drawables.kr;
            case "th": return Rez.Drawables.th;
            case "vn": return Rez.Drawables.vn;
            case "sg": return Rez.Drawables.sg;
            case "nz": return Rez.Drawables.nz;
            default: return null;
        }
    }

    function drawResult(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        // MODIFIÉ: Couleur de fond selon si c'est correct ou non
        if (_lastResultCorrect) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_GREEN);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED);
        }
        dc.clear();
        
        // Texte en blanc sur fond coloré
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // MODIFIÉ: Affichage simplifié sans logos
        if (_lastResultCorrect) {
            dc.drawText(centerX, centerY, Graphics.FONT_LARGE, 
                       "CORRECT", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(centerX, centerY, Graphics.FONT_LARGE, 
                       "INCORRECT", Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    function drawFinalScore(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(centerX, centerY - 50, Graphics.FONT_MEDIUM, 
                   "Quiz Terminé!", Graphics.TEXT_JUSTIFY_CENTER);

        var finalScore = "Score Final: " + _quizManager.getScore() + "/" + 
                        _quizManager.getTotalQuestions();
        dc.drawText(centerX, centerY - 20, Graphics.FONT_SMALL, 
                   finalScore, Graphics.TEXT_JUSTIFY_CENTER);

        var percentage = _quizManager.getScorePercentage() + "%";
        dc.drawText(centerX, centerY, Graphics.FONT_SMALL, 
                   percentage, Graphics.TEXT_JUSTIFY_CENTER);

        // Message selon le score
        var message = "";
        var percent = _quizManager.getScorePercentage();
        if (percent >= 90) {
            message = "Excellent!";
        } else if (percent >= 75) {
            message = "Très bien!";
        } else if (percent >= 50) {
            message = "Pas mal!";
        } else {
            message = "Entraînez-vous!";
        }
        
        dc.drawText(centerX, centerY + 20, Graphics.FONT_SMALL, 
                   message, Graphics.TEXT_JUSTIFY_CENTER);

        dc.drawText(centerX, centerY + 40, Graphics.FONT_TINY, 
                   "SELECT: Nouveau jeu", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, centerY + 55, Graphics.FONT_TINY, 
                   "BACK: Menu principal", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Méthodes publiques pour le delegate
    function getQuizManager() as QuizManager {
        return _quizManager;
    }

    function getGameState() as Symbol {
        return _gameState;
    }

    function setGameState(state as Symbol) as Void {
        _gameState = state;
        
        if (state == :result) {
            startResultTimer();
        } else {
            stopResultTimer();
        }
        
        WatchUi.requestUpdate();
    }

    function setResultTitle(title as String) as Void {
        _lastResultTitle = title;
    }

    // NOUVELLE MÉTHODE: Définir si la réponse était correcte
    function setResultCorrect(isCorrect as Boolean) as Void {
        _lastResultCorrect = isCorrect;
    }

    function getSelectedAnswerIndex() as Number {
        if (_delegate != null && _delegate has :getSelectedAnswerIndex) {
            return _delegate.getSelectedAnswerIndex();
        }
        return 0;
    }

    private function startResultTimer() as Void {
        stopResultTimer();
        
        _resultTimer = new Timer.Timer();
        _resultTimer.start(method(:onResultTimerCallback), 2000, false);
    }

    private function stopResultTimer() as Void {
        if (_resultTimer != null) {
            _resultTimer.stop();
            _resultTimer = null;
        }
    }

    function onResultTimerCallback() as Void {
        if (_gameState == :result) {
            if (_quizManager.isGameFinished()) {
                setGameState(:finalScore);
            } else {
                setGameState(:playing);
                if (_delegate != null && _delegate has :resetSelectedAnswerIndex) {
                    _delegate.resetSelectedAnswerIndex();
                }
            }
        }
    }

    function onHide() as Void {
        stopResultTimer();
    }
}