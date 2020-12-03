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
        } else if buttonState == .running {
            stopTapped()
        } else if buttonState == .runningStopped {
            print("reset stopped")
            buttonState = .readyToBeRun
            mainButton.setTitle("START", for: .normal)
        }
    }
    
    func startTapped() {
        print("time started")
        buttonState = .running
        mainButton.setTitle("STOP", for: .normal)
        let numberFormatter = NumberFormatter()
        let startTime = Date()
        

        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] _ in
            let currentDate = Date()
            let duration = currentDate.timeIntervalSince(startTime)
            
            let formattedNumber = self?.format(duration)
            self?.timerLabel.text = formattedNumber
        })
    }
    
    func stopTapped() {
        print("timer stopped")
        buttonState = .runningStopped
        timer.invalidate()
        mainButton.setTitle("RESET", for: .normal)
        
        guard let capturedTime = timerLabel.text else { return }
        print(capturedTime)
        
        func durationInFeet(_ duration: String) -> String {
            let currentDuration = Double(duration)
            return format((currentDuration! * currentDuration! * 16))
        }

        func durationInMeters(_ duration: String) -> String {
            guard let myDuration = Double(duration) else { return "No Duration Captured" }
            return format((myDuration * myDuration * 16 * 0.3))
        }
        
        feetLabel.text = "\(durationInFeet(capturedTime))ft"
        meterLabel.text = "\(durationInMeters(capturedTime))m"
    }
    
    func resetTapped() {
        
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
        numberLabelStackView.backgroundColor = .gray
        numberLabelStackView.alignment = .fill
        numberLabelStackView.axis = .horizontal
        numberLabelStackView.distribution = .equalSpacing
        
        view.addSubview(numberLabelStackView)
        numberLabelStackView.addSubview(timerLabel)
        numberLabelStackView.addSubview(feetLabel)
        numberLabelStackView.addSubview(meterLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: 80)
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.text = "0.00"
        
        feetLabel.translatesAutoresizingMaskIntoConstraints = false
        feetLabel.font = UIFont.systemFont(ofSize: 40)
        feetLabel.textColor = .white
        feetLabel.textAlignment = .center
        feetLabel.text = "0.00ft"
        
        meterLabel.translatesAutoresizingMaskIntoConstraints = false
        meterLabel.font = UIFont.systemFont(ofSize: 40)
        meterLabel.textColor = .white
        meterLabel.textAlignment = .center
        meterLabel.text = "0.00m"
        
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
            
            meterLabel.topAnchor.constraint(equalTo: feetLabel.bottomAnchor, constant: 20),
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
    
    func transition(the label: UILabel, to thisString: String) {
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
