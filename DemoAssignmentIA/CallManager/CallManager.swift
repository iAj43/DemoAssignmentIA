//
//  CallManager.swift
//  DemoAssignmentIA
//
//  Created by IA on 16/10/24.
//

import UIKit
import CallKit

class CallManager: NSObject {
    
    static let shared = CallManager()
    private var provider: CXProvider!
    private var callController: CXCallController!
    private var callUUID: UUID?
    private var callCXHandle: CXHandle?
    
    // MARK: - init
    override init() {
        super.init()
        setupProvider()
        callController = CXCallController()
    }
    
    private func setupProvider() {
        let providerConfiguration = CXProviderConfiguration(localizedName: "DemoAssignmentIA")
        providerConfiguration.supportsVideo = true
        providerConfiguration.maximumCallGroups = 1
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.supportedHandleTypes = [.phoneNumber]
        provider = CXProvider(configuration: providerConfiguration)
        provider.setDelegate(self, queue: nil)
    }
    
    func reportIncomingCall(uuid: UUID, handle: String, hasVideo: Bool) {
        callUUID = uuid
        callCXHandle = CXHandle(type: .phoneNumber, value: handle)
        
        let callUpdate = CXCallUpdate()
        callUpdate.remoteHandle = callCXHandle
        callUpdate.hasVideo = hasVideo
        
        provider.reportNewIncomingCall(with: uuid, update: callUpdate) { error in
            if let error = error {
                print("Error reporting incoming call: \(error)")
            } else {
                self.handleIncomingCallNotification()
            }
        }
    }
    
    private func handleIncomingCallNotification() {
        if UIApplication.shared.applicationState == .active {
            // App is in foreground - show custom incoming call UI
            showIncomingCallUI()
        } else {
            // App is in background or locked - CallKit will show full-screen UI
        }
    }
    
    private func showIncomingCallUI() {
        let callerName = callCXHandle?.value ?? "Unknown"
        let incomingCallController = IncomingCallController(callerName: callerName)
        
        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            // check if the IncomingCallController is already presented
            if topVC.presentedViewController is IncomingCallController {
                print("Incoming call UI is already presented.")
                return
            }
            if let presentedVC = topVC.presentedViewController as? IncomingCallController {
                presentedVC.dismiss(animated: false) {
                    topVC.present(incomingCallController, animated: true, completion: nil)
                }
            } else {
                topVC.present(incomingCallController, animated: true, completion: nil)
            }
        }
    }
    
    func handleAcceptCall() {
        guard let uuid = callUUID else { return }
        let acceptCallAction = CXAnswerCallAction(call: uuid)
        let transaction = CXTransaction(action: acceptCallAction)
        
        callController.request(transaction) { error in
            if let error = error {
                print("Error accepting call: \(error.localizedDescription)")
            } else {
                print("Call accepted successfully.")
            }
        }
    }
    
    func handleEndCall() {
        guard let uuid = callUUID else { return }
        let endCallAction = CXEndCallAction(call: uuid)
        let transaction = CXTransaction(action: endCallAction)
        
        callController.request(transaction) { error in
            if let error = error {
                print("Error ending call: \(error.localizedDescription)")
            } else {
                print("Call ended successfully.")
                self.callUUID = nil
                self.callCXHandle = nil
            }
        }
    }
    
    private func getCurrentCallUUID() -> UUID? {
        return callUUID
    }
    
    private func getCurrentCallCXHandle() -> CXHandle? {
        return callCXHandle
    }
    
    private func getProvider() -> CXProvider {
        return provider
    }
    
    private func getCallController() -> CXCallController {
        return callController
    }
}
//
// MARK: - CXProviderDelegate
//
extension CallManager: CXProviderDelegate {
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        action.fulfill()
        print("Started call")
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        handleEndCall()
        action.fulfill()
    }
    
    func providerDidReset(_ provider: CXProvider) {
        print("Provider reset")
    }
}
