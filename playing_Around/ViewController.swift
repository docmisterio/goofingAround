import UIKit

class ViewController: UIViewController {
    var titleLabel = UILabel()
    let timerLabel = UILabel()
    let feetLabel = UILabel()
    let meterLabel = UILabel()
    let numberLabelStackView = UIStackView()
    let mainButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        
        setUpLabels()
        setUpConstraints()

        setUpButton()
    }
    
    func setUpButton() {
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        mainButton.setTitle("START", for: .normal)
        mainButton.setTitleColor(.yellow, for: .normal)
        mainButton.titleLabel?.font = UIFont.systemFont(ofSize: 75)
        mainButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("button tapped")
    }
    
    func setUpLabels() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 44)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Cliff Height Timer"
        view.addSubview(titleLabel)
        
        numberLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        numberLabelStackView.backgroundColor = .systemYellow
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
}
