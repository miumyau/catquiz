import UIKit
struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class QuizManager {
     var allQuestions: [Question] = [
        Question(text: "What breed of cat is associated with the 'Cat’s Claws' baseball team?",
                 answers: ["Maine Coon", "Persian", "Siamese", "Bengal"],
                 correctAnswerIndex: 0),
        
        Question(text: "In which sport did a cat named Mayweather participate?",
                 answers: ["Soccer", "Tennis", "Boxing", "Running"],
                 correctAnswerIndex: 2),
        
        Question(text: "Which NHL team has a cat mascot?",
                 answers: ["Boston Bruins", "Florida Panthers", "Detroit Red Wings", "Chicago Blackhawks"],
                 correctAnswerIndex: 1),
        
        Question(text: "From which country did the cat become famous for its 'participation' in soccer matches?",
                 answers: ["England", "Germany", "Brazil", "Argentina"],
                 correctAnswerIndex: 0),
        
        Question(text: "Which cat became a popular mascot for a basketball team?",
                 answers: ["Garfield", "Tom", "Felix", "Big Cat"],
                 correctAnswerIndex: 3),
        
        Question(text: "Which cat was depicted on the jersey of the 'Tigers' soccer team?",
                 answers: ["Lion", "Leopard", "Tiger", "Jaguar"],
                 correctAnswerIndex: 2),
        
        Question(text: "Which cat is the official mascot of the NFL's Carolina Panthers?",
                 answers: ["Leopard", "Black Panther", "Ocelot", "Lion"],
                 correctAnswerIndex: 1),
        
        Question(text: "Which cat became a social media star due to its love for soccer?",
                 answers: ["Nala", "Maru", "Grumpy Cat", "Soccer Cat"],
                 correctAnswerIndex: 3),
        
        Question(text: "Which cat became the hero of an Olympic Games commercial?",
                 answers: ["Tom", "Garfield", "Sylvester", "Felix"],
                 correctAnswerIndex: 2),
        
        Question(text: "Which cat became famous for its parkour skills?",
                 answers: ["Parkour Cat", "Ninja Cat", "Felix", "Tom"],
                 correctAnswerIndex: 0),
        
        Question(text: "Which cat became a mascot for a football team in the English Premier League?",
                 answers: ["Fox", "Tiger", "Cat", "Lion"],
                 correctAnswerIndex: 3),
        
        Question(text: "In which sport do cats compete in short-distance speed?",
                 answers: ["Running", "Soccer", "Baseball", "Agility"],
                 correctAnswerIndex: 0),
        
        Question(text: "Which cat was named 'Mr. Fitness' in a cat contest?",
                 answers: ["Tom", "Felix", "Maru", "Simba"],
                 correctAnswerIndex: 3),
        
        Question(text: "Which cat became a symbol for a tennis tournament?",
                 answers: ["Tiger", "Cheetah", "Puma", "Felix"],
                 correctAnswerIndex: 3),
        
        Question(text: "Which cat became a star in the high-jumping competition?",
                 answers: ["Nala", "Garfield", "Jumping Jack", "Felix"],
                 correctAnswerIndex: 2),
        
        Question(text: "Which cat was the official mascot of the Olympic Games?",
                 answers: ["Misha", "Lion", "Tiger", "Garfield"],
                 correctAnswerIndex: 1),
    ]
    
    

   var selectedQuestions: [Question] = []
         var currentQuestionIndex = 0
         var score = 0
        
        func getCurrentQuestion() -> Question? {
            guard currentQuestionIndex < selectedQuestions.count else {
                return nil
            }
            return selectedQuestions[currentQuestionIndex]
        }
        
        func checkAnswer(_ index: Int) -> Bool {
            guard currentQuestionIndex < selectedQuestions.count else {
                return false
            }
            
            let isCorrect = index == selectedQuestions[currentQuestionIndex].correctAnswerIndex
            if isCorrect {
                score += 1
            }
            return isCorrect
        }
        
        func nextQuestion() -> Bool {
            currentQuestionIndex += 1
            return currentQuestionIndex < selectedQuestions.count
        }
        
    func resetQuiz() {
           selectedQuestions = Array(allQuestions.shuffled().prefix(10))
           currentQuestionIndex = 0
           score = 0
       }
    
    func saveScore() {
            UserDefaults.standard.set(score, forKey: "lastScore")
        }
    }
