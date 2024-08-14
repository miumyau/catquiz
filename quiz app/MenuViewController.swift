import UIKit

class MenuViewController: UIViewController {
    
    let startButton = UIButton()
    let scoreLabel = UILabel()
    let scoreValueLabel = UILabel()
    let imageView = UIImageView()
    let rateButton = UIButton()
    var overlayView: UIView?
    let scoreImageView = UIImageView()
    override func viewDidLoad() {
        updateScore()
        super.viewDidLoad()
        setupUI()
        addAlphaGradientToButton(button: startButton, colors: [UIColor.pink
                                                               , UIColor.pink2])
        addAlphaGradientToButton(button: rateButton, colors: [UIColor.mint, UIColor.green1])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.layer.sublayers?.first?.frame = startButton.bounds
        rateButton.layer.sublayers?.first?.frame = rateButton.bounds
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateScore()
    }
    
    func addAlphaGradientToButton(button: UIButton, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = colors.map { $0.withAlphaComponent(0.8).cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = button.layer.cornerRadius
        button.layer.sublayers?.forEach {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
    }
    
    
    
    
    private func setupUI() {
        updateScore()
        view.backgroundColor = UIColor(named: "sand")
        
        imageView.image = UIImage(named: "menu")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        scoreLabel.text = "Your Score:"
        scoreLabel.font = UIFont(name: "Katibeh-Regular", size: 36)
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        
        scoreValueLabel.font = UIFont(name: "Katibeh-Regular", size: 40)
        scoreValueLabel.textColor = .black
        scoreValueLabel.textAlignment = .center
        scoreValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreValueLabel)
        
        if let scoreGIF = UIImage.gif(name: "star") {
            scoreImageView.image = scoreGIF
            scoreImageView.contentMode = .scaleAspectFit
        }
        scoreImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreImageView)
        
        let scoreStackView = UIStackView(arrangedSubviews: [scoreValueLabel, scoreImageView])
        scoreStackView.axis = .horizontal
        scoreStackView.spacing = 10
        scoreStackView.alignment = .center
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreStackView)
        
        NSLayoutConstraint.activate([
            scoreImageView.centerYAnchor.constraint(equalTo: scoreValueLabel.centerYAnchor,constant: -10)
        ])
        startButton.setTitle("Start!", for: .normal)
        startButton.backgroundColor = UIColor(named: "pink2")?.withAlphaComponent(0.5)
        startButton.setTitleColor(.black, for: .normal)
        startButton.layer.cornerRadius = 25
        startButton.layer.opacity = 0.8
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.titleLabel?.font = UIFont(name: "IrishGrover-Regular", size: 32)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        view.addSubview(startButton)
        
        rateButton.setTitle("Rate Us", for: .normal)
        startButton.backgroundColor = UIColor(named: "mint")?.withAlphaComponent(0.5)
        rateButton.setTitleColor(.black, for: .normal)
        rateButton.layer.cornerRadius = 25
        rateButton.contentHorizontalAlignment = .center
        rateButton.contentVerticalAlignment = .bottom
        rateButton.layer.borderWidth = 2
        rateButton.layer.borderColor = UIColor.black.cgColor
        rateButton.titleLabel?.font = UIFont(name: "Katibeh-Regular", size: 36)
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        rateButton.addTarget(self, action: #selector(rateUs), for: .touchUpInside)
        view.addSubview(rateButton)
        
        // Размещение элементов
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            scoreImageView.widthAnchor.constraint(equalToConstant: 65),
            scoreImageView.heightAnchor.constraint(equalToConstant: 65),
            
            scoreLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scoreStackView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            scoreStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: scoreStackView.bottomAnchor, constant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            
            rateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 30),
            rateButton.widthAnchor.constraint(equalToConstant: 200),
            rateButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func updateScore() {
        let lastScore = UserDefaults.standard.integer(forKey: "lastScore")
        scoreValueLabel.text = "\(lastScore)"
    }
    
    @objc private func startQuiz() {
        let quizVC = QuizViewController()
        quizVC.modalPresentationStyle = .fullScreen
        present(quizVC, animated: true, completion: nil)
    }
    
    
    @objc private func rateUs() {
        showOverlayWithGIFAndText()
    }
    
    private func showOverlayWithGIFAndText() {
        overlayView = UIView(frame: self.view.bounds)
        overlayView?.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        overlayView?.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideOverlay))
        overlayView?.addGestureRecognizer(tapGesture)
        
        if let gifImage = UIImage.gif(name: "heart") {
            let gifImageView = UIImageView(image: gifImage)
            gifImageView.contentMode = .scaleAspectFit
            gifImageView.translatesAutoresizingMaskIntoConstraints = false
            overlayView?.addSubview(gifImageView)
            
            let thankYouLabel = UILabel()
            thankYouLabel.text = "Thank You"
            thankYouLabel.font = UIFont(name: "Katibeh-Regular", size: 40)
            thankYouLabel.textColor = .black
            thankYouLabel.textAlignment = .center
            thankYouLabel.translatesAutoresizingMaskIntoConstraints = false
            overlayView?.addSubview(thankYouLabel)
            
            NSLayoutConstraint.activate([
                gifImageView.centerXAnchor.constraint(equalTo: overlayView!.centerXAnchor),
                gifImageView.centerYAnchor.constraint(equalTo: overlayView!.centerYAnchor),
                gifImageView.widthAnchor.constraint(equalToConstant: 200),
                gifImageView.heightAnchor.constraint(equalToConstant: 200),
                
                thankYouLabel.centerXAnchor.constraint(equalTo: overlayView!.centerXAnchor),
                thankYouLabel.topAnchor.constraint(equalTo: gifImageView.bottomAnchor, constant: 20)
            ])
        }
        
        self.view.addSubview(overlayView!)
    }
    
    @objc private func hideOverlay() {
        overlayView?.removeFromSuperview()
    }
}

extension UIImage {
    public class func gif(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("Не удалось найти gif файл с именем \(name)")
            return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Не удалось получить данные из gif файла с именем \(name)")
            return nil
        }
        
        return UIImage.gif(data: imageData)
    }
    
    public class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Не удалось создать источник изображения для gif файла")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration: Double = 0
        
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
                
                let delaySeconds = UIImage.delayForImageAtIndex(Int(i), source: source)
                duration += delaySeconds
            }
        }
        
        if duration == 0 {
            duration = Double(count) / 24.0
        }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = (cfProperties! as NSDictionary)[kCGImagePropertyGIFDictionary as String] as! CFDictionary
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties, unsafeBitCast(kCGImagePropertyGIFUnclampedDelayTime, to: UnsafeRawPointer.self)),
            to: AnyObject.self
        )
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(
                CFDictionaryGetValue(gifProperties, unsafeBitCast(kCGImagePropertyGIFDelayTime, to: UnsafeRawPointer.self)),
                to: AnyObject.self
            )
        }
        
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        }
        
        return delay
    }
    
    
}
