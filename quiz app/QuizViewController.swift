import UIKit

class QuizViewController: UIViewController {
    
    let questionLabel = UILabel()
    let answerButtons: [UIButton] = [UIButton(), UIButton(), UIButton(), UIButton()]
    let quizManager = QuizManager()
    
    
    
    let nextButton = UIButton()
    let finishButton = UIButton()
    
    let correctAnswerImageView = UIImageView()
    var isQuizFinished = false
    var overlayView: UIView?
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        quizManager.resetQuiz()
        showQuestion()
        
        addGradientToButton(button: finishButton, colors: [UIColor.systemPink, UIColor.systemPurple])
        addGradientToButton(button: nextButton, colors: [UIColor.systemYellow, UIColor.systemOrange])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.layer.sublayers?.first?.frame = nextButton.bounds
        finishButton.layer.sublayers?.first?.frame = finishButton.bounds
    }
    
    func addGradientToButton(button: UIButton, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = button.layer.cornerRadius
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "quiz")
        
        // Настройка вопроса
        questionLabel.font = UIFont(name: "Katibeh-Regular", size: 40)
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = UIColor(named: "next")
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Katibeh-Regular", size: 28)
        nextButton.layer.cornerRadius = 15
        nextButton.layer.opacity = 0.8
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.borderWidth = 2
        
        finishButton.layer.borderColor = UIColor.black.cgColor
        finishButton.layer.borderWidth = 2
        finishButton.layer.opacity = 0.8
        finishButton.setTitle("Finish", for: .normal)
        finishButton.setTitleColor(.black, for: .normal)
        finishButton.backgroundColor = UIColor(named: "finish")
        finishButton.titleLabel?.font = UIFont(name: "Katibeh-Regular", size: 28)
        finishButton.layer.cornerRadius = 15
        finishButton.addTarget(self, action: #selector(finishQuiz), for: .touchUpInside)
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(finishButton)
        
        for button in answerButtons {
            button.backgroundColor = UIColor(named: "green")
            button.layer.opacity = 0.8
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 15
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 2
            button.titleLabel?.font = UIFont(name: "Katibeh-Regular", size: 30)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
        
        if let correctGIF = UIImage.gif(name: "correct") {
            correctAnswerImageView.image = correctGIF
            correctAnswerImageView.contentMode = .scaleAspectFit
        }
        correctAnswerImageView.contentMode = .scaleAspectFit
        correctAnswerImageView.translatesAutoresizingMaskIntoConstraints = false
        correctAnswerImageView.isHidden = true
        view.addSubview(correctAnswerImageView)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            answerButtons[0].topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            answerButtons[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerButtons[0].trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            answerButtons[0].heightAnchor.constraint(equalToConstant: 70),
            
            answerButtons[1].topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            answerButtons[1].leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            answerButtons[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answerButtons[1].heightAnchor.constraint(equalToConstant: 70),
            
            answerButtons[2].topAnchor.constraint(equalTo: answerButtons[0].bottomAnchor, constant: 20),
            answerButtons[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerButtons[2].trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            answerButtons[2].heightAnchor.constraint(equalToConstant: 70),
            
            answerButtons[3].topAnchor.constraint(equalTo: answerButtons[1].bottomAnchor, constant: 20),
            answerButtons[3].leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            answerButtons[3].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answerButtons[3].heightAnchor.constraint(equalToConstant: 70),
            
            nextButton.topAnchor.constraint(equalTo: answerButtons[3].bottomAnchor, constant: 30),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            finishButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.widthAnchor.constraint(equalToConstant: 200),
            finishButton.heightAnchor.constraint(equalToConstant: 50),
            
            correctAnswerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            correctAnswerImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 200),
            correctAnswerImageView.widthAnchor.constraint(equalToConstant: 100),
            correctAnswerImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func showQuestion() {
        let currentQuestion = quizManager.getCurrentQuestion()
        questionLabel.text = currentQuestion?.text
        
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(currentQuestion?.answers[index], for: .normal)
            button.backgroundColor = UIColor(named: "pink")
            button.isEnabled = true
        }
        
        correctAnswerImageView.isHidden = true
    }
    
    @objc private func nextQuestion() {
        if quizManager.nextQuestion() {
            showQuestion()
        } else {
            showResult()
        }
    }
    
    @objc private func finishQuiz() {
        quizManager.saveScore()
        UserDefaults.standard.set(quizManager.score, forKey: "lastScore") 
        showResult()
    }
    
    
    @objc private func answerTapped(_ sender: UIButton) {
        guard let index = answerButtons.firstIndex(of: sender) else { return }
        let isCorrect = quizManager.checkAnswer(index)
        
        sender.backgroundColor = isCorrect ? .correct : .wrong
        
        for button in answerButtons {
            button.isEnabled = false
        }
        
        if isCorrect {
            correctAnswerImageView.isHidden = false
        }
    }
    
    
    
    private func showResult() {
        
        overlayView?.removeFromSuperview()
        
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.white
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.overlayView = overlayView
        view.addSubview(overlayView)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.sand.cgColor, UIColor.pink2.cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        overlayView.layer.insertSublayer(gradientLayer, at: 0)
        
        if let gifImage = UIImage.gif(name: "finish") {
            let gifImageView = UIImageView(image: gifImage)
            gifImageView.contentMode = .scaleAspectFit
            gifImageView.translatesAutoresizingMaskIntoConstraints = false
            overlayView.addSubview(gifImageView)
            
            let resultLabel = UILabel()
            resultLabel.text = "Your Score: \(quizManager.score)"
            resultLabel.textColor = .black
            resultLabel.font = UIFont(name: "Katibeh-Regular", size: 40)
            resultLabel.textAlignment = .center
            resultLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let retryButton = UIButton()
            retryButton.setTitle("Retry", for: .normal)
            retryButton.backgroundColor = UIColor(named: "mint")
            retryButton.setTitleColor(.black, for: .normal)
            retryButton.layer.borderColor = UIColor.black.cgColor
            retryButton.layer.borderWidth = 2
            retryButton.titleLabel?.font = UIFont(name: "Katibeh-Regular", size: 36)
            retryButton.layer.cornerRadius = 25
            retryButton.addTarget(self, action: #selector(restartQuiz), for: .touchUpInside)
            retryButton.translatesAutoresizingMaskIntoConstraints = false
            
            let menuButton = UIButton()
            menuButton.setTitle("Menu", for: .normal)
            menuButton.backgroundColor = UIColor(named: "finish")
            menuButton.setTitleColor(.black, for: .normal)
            menuButton.layer.borderColor = UIColor.black.cgColor
            menuButton.layer.borderWidth = 2
            menuButton.titleLabel?.font = UIFont(name: "Katibeh-Regular", size: 36)
            menuButton.layer.cornerRadius = 25
            menuButton.addTarget(self, action: #selector(dismissQuiz), for: .touchUpInside)
            menuButton.translatesAutoresizingMaskIntoConstraints = false
            
            overlayView.addSubview(resultLabel)
            overlayView.addSubview(retryButton)
            overlayView.addSubview(menuButton)
            
            NSLayoutConstraint.activate([
                overlayView.topAnchor.constraint(equalTo: view.topAnchor),
                overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                gifImageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                gifImageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: 200),
                gifImageView.widthAnchor.constraint(equalToConstant: 200),
                gifImageView.heightAnchor.constraint(equalToConstant: 300),
                
                resultLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                resultLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: -160),
                resultLabel.widthAnchor.constraint(equalTo: overlayView.widthAnchor, multiplier: 0.8),
                
                retryButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
                retryButton.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                retryButton.widthAnchor.constraint(equalToConstant: 200),
                retryButton.heightAnchor.constraint(equalToConstant: 60),
                
                menuButton.topAnchor.constraint(equalTo: retryButton.bottomAnchor, constant: 20),
                menuButton.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                menuButton.widthAnchor.constraint(equalToConstant: 200),
                menuButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    
    @objc private func restartQuiz() {
        overlayView?.removeFromSuperview()
        overlayView = nil
        quizManager.resetQuiz()
        showQuestion()
    }
    
    @objc private func dismissQuiz() {
        dismiss(animated: true, completion: nil)
    }
}
