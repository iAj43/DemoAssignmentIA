//
//  CustomViews.swift
//  DemoAssignmentIA
//
//  Created by IA on 16/10/24.
//

import UIKit
//
// MARK: - TitleLabel
//
class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        textColor = .black
        font = .systemFont(ofSize: 18)
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomButton
//
class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - RoundButtonView
//
class RoundButtonView: UIView {
    
    // MARK: - create UI
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let roundButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomLabel)
        addSubview(roundButton)
        // Layout Constraint
        NSLayoutConstraint.activate([
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomLabel.heightAnchor.constraint(equalToConstant: 20),
            
            roundButton.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -10),
            roundButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundButton.widthAnchor.constraint(equalToConstant: 80),
            roundButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
