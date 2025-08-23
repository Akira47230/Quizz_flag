// source/QuizManager.mc - Modifié pour 3 réponses au lieu de 4
import Toybox.Lang;
import Toybox.Math;

class QuizManager {
    private var _questions as Array<Dictionary>;
    private var _currentQuestionIndex as Number;
    private var _score as Number;
    private var _totalQuestions as Number;
    private var _isGameActive as Boolean;

    function initialize() {
        _currentQuestionIndex = 0;
        _score = 0;
        _totalQuestions = 20;
        _isGameActive = false;
        _questions = [];
    }

    function startNewGame() as Void {
        _currentQuestionIndex = 0;
        _score = 0;
        _isGameActive = true;
        generateQuestions();
    }

    function generateQuestions() as Void {
        _questions = [];
        var countries = FlagData.getRandomCountries(_totalQuestions);
        
        for (var i = 0; i < countries.size(); i++) {
            var question = generateQuestion(countries[i]);
            _questions.add(question);
        }
    }

    function generateQuestion(correctCountry as Dictionary) as Dictionary {
        // Génération de seulement 2 mauvaises réponses au lieu de 3
        var wrongAnswers = FlagData.generateWrongAnswers(correctCountry, 2);
        var allAnswers = [correctCountry[:name]];
        
        // Ajouter les mauvaises réponses
        for (var i = 0; i < wrongAnswers.size(); i++) {
            allAnswers.add(wrongAnswers[i]);
        }
        
        // Mélanger les réponses
        for (var i = allAnswers.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = allAnswers[i];
            allAnswers[i] = allAnswers[j];
            allAnswers[j] = temp;
        }
        
        // Trouver la position de la bonne réponse
        var correctIndex = 0;
        for (var i = 0; i < allAnswers.size(); i++) {
            if (allAnswers[i].equals(correctCountry[:name])) {
                correctIndex = i;
                break;
            }
        }
        
        return {
            :flag => correctCountry[:flag],
            :correctAnswer => correctCountry[:name],
            :answers => allAnswers,
            :correctIndex => correctIndex
        };
    }

    function getCurrentQuestion() as Dictionary or Null {
        if (_currentQuestionIndex < _questions.size()) {
            return _questions[_currentQuestionIndex];
        }
        return null;
    }

    function answerQuestion(selectedIndex as Number) as Boolean {
        var currentQuestion = getCurrentQuestion();
        if (currentQuestion == null) {
            return false;
        }
        
        var isCorrect = (selectedIndex == currentQuestion[:correctIndex]);
        
        if (isCorrect) {
            _score++;
        }
        
        _currentQuestionIndex++;
        
        if (_currentQuestionIndex >= _questions.size()) {
            _isGameActive = false;
        }
        
        return isCorrect;
    }

    function isGameActive() as Boolean {
        return _isGameActive;
    }

    function getCurrentQuestionNumber() as Number {
        return _currentQuestionIndex + 1;
    }

    function getTotalQuestions() as Number {
        return _totalQuestions;
    }

    function getScore() as Number {
        return _score;
    }

    function getScorePercentage() as Number {
        if (_totalQuestions == 0) {
            return 0;
        }
        return (_score * 100) / _totalQuestions;
    }

    function isGameFinished() as Boolean {
        return _currentQuestionIndex >= _questions.size();
    }
}