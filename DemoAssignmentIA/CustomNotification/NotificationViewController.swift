//
//  NotificationViewController.swift
//  CustomNotification
//
//  Created by IA on 15/10/24.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet weak var declineView: UIView!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var declineLabel: UILabel!
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var acceptLabel: UILabel!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//
// MARK: - UNNotificationContentExtension
//
extension NotificationViewController: UNNotificationContentExtension {
    func didReceive(_ notification: UNNotification) {
        self.titleLabel?.text = Constants.Strings.customBannerNotification
    }
}
