import UIKit

class ViewController: UIViewController {
    var titleLabel = UILabel()
    let timerLabel = UILabel()
    let feetLabel = UILabel()
    let meterLabel = UILabel()
    let numberLabelStackView = UIStackView()
    let mainButton = UIButton()
    
    override func loadView() {
        super.viewDidLoad()
        view = UIView()
        
        setUpLabels()
        setUpConstraints()
        
        setUpButton()
    }
    
    func setButtonState(_ state: ButtonState) {
        switch state {
        case .ready:
            mainButton.setTitle("START", for: .normal)
            mainButton.setTitleColor(.white, for: .normal)
            mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 75)
        case .running:
            mainButton.setTitle("STOP", for: .normal)
            mainButton.setTitleColor(.white, for: .normal)
            mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 75)
        case .stopped:
            mainButton.setTitle("RESET", for: .normal)
            mainButton.setTitleColor(.white, for: .normal)
            mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 75)
        }
    }
    
    @objc func buttonTapped() {
        let numberFormatter = NumberFormatter()
        let startTime = Date()
        
        func format(timer: Double) -> String {
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.minimumIntegerDigits = 1
            
            guard let formattedNumber = numberFormatter.string(from: NSNumber(value: timer)) else { return "" }
            return formattedNumber
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] _ in
            let currentDate = Date()
            let duration = currentDate.timeIntervalSince(startTime)
            
            let formattedNumber = format(timer: duration)
            self?.timerLabel.text = formattedNumber
        })
    }
    
    func startTapped() {
        
    }
    
    func stopTapped() {
        
    }
    
    func resetTapped() {
        
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
        feetLabel.text = "0.00 ft"
        
        meterLabel.translatesAutoresizingMaskIntoConstraints = false
        meterLabel.font = UIFont.systemFont(ofSize: 40)
        meterLabel.textColor = .white
        meterLabel.textAlignment = .center
        meterLabel.text = "0.00 m"
        
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
        case ready, running, stopped
    }
}
