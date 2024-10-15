//
//  IncomingCallController.swift
//  DemoAssignmentIA
//
//  Created by IA on 15/10/24.
//

import UIKit
import CallKit

class IncomingCallController: UIViewController {
    
    // MARK: - adding DI
    private var callerName: String
    
    init(callerName: String) {
        self.callerName = callerName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - create UI
    private lazy var callFromLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "\(Constants.Strings.incomingCallFrom) \(callerName)"
        return label
    }()
    
    private lazy var declineButtonView: RoundButtonView = {
        let view = RoundButtonView()
        view.bottomLabel.text = Constants.Strings.decline
        view.roundButton.backgroundColor = .systemRed
        view.roundButton.setImage(UIImage(named: Constants.Images.iconDecline), for: .normal)
        view.roundButton.addTarget(self, action: #selector(handleDeclineCall), for: .touchUpInside)
        return view
    }()
    
    private lazy var acceptButtonView: RoundButtonView = {
        let view = RoundButtonView()
        view.bottomLabel.text = Constants.Strings.accept
        view.roundButton.backgroundColor = .systemBlue
        view.roundButton.setImage(UIImage(named: Constants.Images.iconAccept), for: .normal)
        view.roundButton.addTarget(self, action: #selector(handleAcceptCall), for: .touchUpInside)
        return view
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
//
// MARK: - handle button actions
//
extension IncomingCallController {
    
    @objc private func handleAcceptCall(_ sender: UIButton) {
        CallManager.shared.handleAcceptCall()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleDeclineCall(_ sender: UIButton) {
        CallManager.shared.handleEndCall()
        dismiss(animated: true, completion: nil)
    }
}
//
// MARK: - setupUI
//
extension IncomingCallController {
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(callFromLabel)
        view.addSubview(declineButtonView)
        view.addSubview(acceptButtonView)
        // Layout Constraint
        NSLayoutConstraint.activate([
            callFromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            callFromLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            callFromLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            declineButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            declineButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            declineButtonView.widthAnchor.constraint(equalToConstant: 80),
            declineButtonView.heightAnchor.constraint(equalToConstant: 80),
            
            acceptButtonView.bottomAnchor.constraint(equalTo: declineButtonView.bottomAnchor),
            acceptButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            acceptButtonView.widthAnchor.constraint(equalToConstant: 80),
            acceptButtonView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
