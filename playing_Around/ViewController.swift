import UIKit

class ViewController: UIViewController {
    var titleLabel = UILabel()
    let timerLabel = UILabel()
    let feetLabel = UILabel()
    let meterLabel = UILabel()
    let numberLabelStackView = UIStackView()
    let mainButton = UIButton()
    var timer = Timer()
    var buttonState: ButtonState = .readyToBeRun
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        
        setUpLabels()
        setUpConstraints()
        setUpButton()
    }

    
    @objc func buttonTapped() {
        if buttonState == .readyToBeRun {
            startTapped()
            
            buttonState = .running
            mainButton.setTitle("STOP", for: .normal)
            mainButton.setTitleColor(.red, for: .normal)
            
        } else if buttonState == .running {
            stopTapped()
            
            buttonState = .runningStopped
            mainButton.setTitle("RESET", for: .normal)
            mainButton.setTitleColor(.white, for: .normal)

        } else if buttonState == .runningStopped {
            resetTapped()
            
            buttonState = .readyToBeRun
            mainButton.setTitle("START", for: .normal)
        }
    }
    
    func startTapped() {
        let startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] _ in
            let currentDate = Date()
            let duration = currentDate.timeIntervalSince(startTime)
            
            let formattedNumber = self?.format(duration)
            self?.timerLabel.text = formattedNumber
        })
    }
    
    func stopTapped() {
        timer.invalidate()
        guard let capturedTime = timerLabel.text else { return }
        
        feetLabel.alpha = 1
        meterLabel.alpha = 1
        animate(the: feetLabel, to: "\(durationInFeet(capturedTime))ft")
        animate(the: meterLabel, to: "\(durationInMeters(capturedTime))m")
    }
    
    func resetTapped() {
        feetLabel.alpha = 0
        meterLabel.alpha = 0
        animate(the: timerLabel, to: "0:00")
    }
    
    func durationInFeet(_ duration: String) -> String {
        guard let currentDuration = Double(duration) else { return "No Duration Captured."}
        return format((currentDuration * currentDuration * 16))
    }

    func durationInMeters(_ duration: String) -> String {
        guard let currentDuration = Double(duration) else { return "No Duration Captured." }
        return format((currentDuration * currentDuration * 16 * 0.3))
    }
    
    func format(_ timer: Double) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: timer)) else { return "" }
        return formattedNumber
    }
    
    func setUpButton() {
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.setTitle("START", for: .normal)
        mainButton.setTitleColor(.white, for: .normal)
        mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 75)
        mainButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setUpLabels() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 44)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Cliff Height Timer"
        view.addSubview(titleLabel)
        
        numberLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        numberLabelStackView.alignment = .fill
        numberLabelStackView.axis = .horizontal
        numberLabelStackView.distribution = .equalSpacing
        
        view.addSubview(numberLabelStackView)
        numberLabelStackView.addSubview(timerLabel)
        numberLabelStackView.addSubview(feetLabel)
        numberLabelStackView.addSubview(meterLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: 100)
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.text = "0.00"
        
        feetLabel.translatesAutoresizingMaskIntoConstraints = false
        feetLabel.font = UIFont.systemFont(ofSize: 75)
        feetLabel.textColor = .white
        feetLabel.textAlignment = .center
        feetLabel.text = "0.00ft"
        feetLabel.alpha = 0
        
        meterLabel.translatesAutoresizingMaskIntoConstraints = false
        meterLabel.font = UIFont.systemFont(ofSize: 75)
        meterLabel.textColor = .white
        meterLabel.textAlignment = .center
        meterLabel.text = "0.00m"
        meterLabel.alpha = 0

        
        view.addSubview(mainButton)
    }
    
    func setUpConstraints() {
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            numberLabelStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            numberLabelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberLabelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            timerLabel.topAnchor.constraint(equalTo: numberLabelStackView.topAnchor, constant: 50),
            timerLabel.trailingAnchor.constraint(equalTo: numberLabelStackView.trailingAnchor, constant: -20),
            timerLabel.leadingAnchor.constraint(equalTo: numberLabelStackView.leadingAnchor, constant: 20),
            
            feetLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),
            feetLabel.trailingAnchor.constraint(equalTo: numberLabelStackView.trailingAnchor, constant: -20),
            feetLabel.leadingAnchor.constraint(equalTo: numberLabelStackView.leadingAnchor, constant: 20),
            
            meterLabel.topAnchor.constraint(equalTo: feetLabel.bottomAnchor, constant: 40),
            meterLabel.trailingAnchor.constraint(equalTo: numberLabelStackView.trailingAnchor, constant: -20),
            meterLabel.leadingAnchor.constraint(equalTo: numberLabelStackView.leadingAnchor, constant: 20),
            
            mainButton.topAnchor.constraint(equalTo: numberLabelStackView.bottomAnchor, constant: 20),
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    enum ButtonState {
        case readyToBeRun, running, runningStopped
    }
    
    func animate(the label: UILabel, to thisString: String) {
        let transition = CATransition()
        transition.duration = 0.2
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ [] in
            label.text = thisString
            label.layer.add(transition, forKey: kCATransition)
        })
        CATransaction.commit()
    }
}
