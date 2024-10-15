//
//  HomeController.swift
//  DemoAssignmentIA
//
//  Created by IA on 15/10/24.
//

import UIKit

class HomeController: UIViewController {
    
    private var callerName: String = "John Doe" // replace original caller name here
    
    // MARK: - create UI
    private lazy var customNotificationButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(Constants.Strings.scheduleCustomNotification, for: .normal)
        button.addTarget(self, action: #selector(handleCustomNotification), for: .touchUpInside)
        return button
    }()
    
    private lazy var incomingCallNotificationButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(Constants.Strings.scheduleIncomingCallNotification, for: .normal)
        button.addTarget(self, action: #selector(handleIncomingCallNotification), for: .touchUpInside)
        return button
    }()
    
    private lazy var notesLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "\(Constants.Strings.notesTitle) \(Constants.waitingSecond) \(Constants.Strings.seconds)"
        label.font = .systemFont(ofSize: 16)
        label.isHidden = true
        return label
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
extension HomeController {
    
    @objc private func handleCustomNotification() {
        notesLabel.isHidden = false
        let content = UNMutableNotificationContent()
        content.title = Constants.Strings.incomingCall
        content.body = "\(Constants.Strings.incomingCallFrom) \(callerName)"
        content.sound = .default
        content.badge = NSNumber(value: 0)
        content.categoryIdentifier = Constants.Identifiers.notificationCategory

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Constants.waitingSecond, repeats: false)
        let request = UNNotificationRequest(identifier:  Constants.Identifiers.notificationRequest, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    @objc private func handleIncomingCallNotification() {
        notesLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.waitingSecond) {
            self.receiveCall(handle: self.callerName, hasVideo: true)
        }
    }
    
    private func receiveCall(handle: String, hasVideo: Bool) {
        let uuid = UUID()
        CallManager.shared.reportIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo)
        
        let incomingCallController = IncomingCallController(callerName: handle)
        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            incomingCallController.modalPresentationStyle = .fullScreen
            topVC.present(incomingCallController, animated: true, completion: nil)
        }
    }
}
//
// MARK: - setupUI
//
extension HomeController {
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(customNotificationButton)
        view.addSubview(incomingCallNotificationButton)
        view.addSubview(notesLabel)
        // Layout Constraint
        NSLayoutConstraint.activate([
            customNotificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customNotificationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            customNotificationButton.widthAnchor.constraint(equalToConstant: 300),
            customNotificationButton.heightAnchor.constraint(equalToConstant: 48),
            
            incomingCallNotificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            incomingCallNotificationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            incomingCallNotificationButton.widthAnchor.constraint(equalToConstant: 300),
            incomingCallNotificationButton.heightAnchor.constraint(equalToConstant: 48),
            
            notesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notesLabel.topAnchor.constraint(equalTo: incomingCallNotificationButton.bottomAnchor, constant: 40)
        ])
    }
}
