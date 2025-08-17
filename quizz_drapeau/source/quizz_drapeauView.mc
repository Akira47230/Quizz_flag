// source/quizz_drapeauView.mc - Version avec sélection visuelle
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class quizz_drapeauView extends WatchUi.View {
    private var _quizManager as QuizManager;
    private var _gameState as Symbol; // :menu, :playing, :result, :finalScore
    private var _delegate as quizz_drapeauDelegate;

    function initialize() {
        View.initialize();
        _quizManager = new QuizManager();
        _gameState = :menu;
        _delegate = null;
    }

    function setDelegate(delegate as quizz_drapeauDelegate) as Void {
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
                   
        dc.drawText(centerX, centerY + 35, Graphics.FONT_TINY, 
                   "MENU pour quitter", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawQuestion(dc as Dc) as Void {
        var question = _quizManager.getCurrentQuestion();
        if (question == null) {
            return;
        }

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // Numéro de question et score
        var questionText = _quizManager.getCurrentQuestionNumber() + "/" + 
                          _quizManager.getTotalQuestions() + 
                          " - Score: " + _quizManager.getScore();
        dc.drawText(centerX, 10, Graphics.FONT_TINY, questionText, Graphics.TEXT_JUSTIFY_CENTER);

        // Zone pour le drapeau - ici vous placerez votre bitmap du drapeau
        var flagX = centerX - 40;
        var flagY = 30;
        var flagWidth = 80;
        var flagHeight = 50;
        
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(flagX, flagY, flagWidth, flagHeight);
        
        // Tentative d'affichage du drapeau (si disponible)
        try {
            var flagBitmap = WatchUi.loadResource(Rez.Drawables[question[:flag]]);
            if (flagBitmap != null) {
                dc.drawBitmap(flagX, flagY, flagBitmap);
            } else {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(centerX, flagY + 20, Graphics.FONT_XTINY, 
                           question[:flag], Graphics.TEXT_JUSTIFY_CENTER);
            }
        } catch (e) {
            // Si le drapeau n'est pas trouvé, afficher le nom du fichier
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX, flagY + 20, Graphics.FONT_XTINY, 
                       question[:flag], Graphics.TEXT_JUSTIFY_CENTER);
        }

        // Options de réponse avec sélection
        var answers = question[:answers] as Array;
        var startY = flagY + flagHeight + 15;
        var buttonHeight = 22;
        var selectedIndex = (_delegate != null) ? _delegate.getSelectedAnswerIndex() : 0;
        
        for (var i = 0; i < answers.size(); i++) {
            var y = startY + (i * buttonHeight);
            var isSelected = (i == selectedIndex);
            
            // Couleur du bouton selon la sélection
            var buttonColor = isSelected ? Graphics.COLOR_BLUE : Graphics.COLOR_DK_GRAY;
            var textColor = isSelected ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY;
            
            dc.setColor(buttonColor, Graphics.COLOR_TRANSPARENT);
            dc.fillRoundedRectangle(10, y, width - 20, buttonHeight - 2, 3);
            
            dc.setColor(textColor, Graphics.COLOR_TRANSPARENT);
            var buttonText = (i + 1) + ". " + answers[i];
            dc.drawText(centerX, y + 4, Graphics.FONT_XTINY, buttonText, Graphics.TEXT_JUSTIFY_CENTER);
        }
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, height - 15, Graphics.FONT_XTINY, 
                   "UP/DOWN: naviguer, SELECT: répondre", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawResult(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        // Titre de résultat sera défini par le delegate
        dc.drawText(centerX, centerY - 30, Graphics.FONT_MEDIUM, 
                   getResultTitle(), Graphics.TEXT_JUSTIFY_CENTER);

        // Score actuel
        var scoreText = "Score: " + _quizManager.getScore() + "/" + 
                       _quizManager.getCurrentQuestionNumber();
        dc.drawText(centerX, centerY, Graphics.FONT_SMALL, scoreText, Graphics.TEXT_JUSTIFY_CENTER);

        if (_quizManager.isGameFinished()) {
            dc.drawText(centerX, centerY + 25, Graphics.FONT_TINY, 
                       "SELECT pour le score final", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(centerX, centerY + 25, Graphics.FONT_TINY, 
                       "SELECT pour continuer", Graphics.TEXT_JUSTIFY_CENTER);
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

    // Getters pour le delegate
    function getQuizManager() as QuizManager {
        return _quizManager;
    }

    function getGameState() as Symbol {
        return _gameState;
    }

    function setGameState(state as Symbol) as Void {
        _gameState = state;
        WatchUi.requestUpdate();
    }

    // Variables pour stocker le résultat temporaire
    private var _lastResultTitle as String = "";
    
    function setResultTitle(title as String) as Void {
        _lastResultTitle = title;
    }
    
    function getResultTitle() as String {
        return _lastResultTitle;
    }

    function onHide() as Void {
    }
}