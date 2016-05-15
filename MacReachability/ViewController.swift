//
//  ViewController.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/15.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var centerStackView: NSStackView!
    @IBOutlet weak var logoImageView: NSImageView!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var messageLabel: NSTextField!
    @IBOutlet weak var slowHintLabel: NSTextField!
    @IBOutlet weak var closeButton: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    var slowTimerCancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.target = NSApp.delegate
        closeButton.action = #selector(AppDelegate.closeMainWindow)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        progressIndicator.hidden = false
        centerStackView.hidden = true
        slowHintLabel.alphaValue = 0.0
        
        progressIndicator.startAnimation(self)
        ReachabilityChecker.checkInBackgroundWithBlock { (status) in
            // I just want to enjoy the chrysanthemum spinning...
            delayWithoutCancellable(seconds: 1) {
                self.slowTimerCancellable?()
                self.configureMessagesWithResult(status)
            }
        }
        
        slowTimerCancellable = delay(seconds: 3) {
            fade(self.slowHintLabel, toVisible: true)
        }
    }
    
    func configureMessagesWithResult(result: Bool) {
        progressIndicator.hidden = true
        centerStackView.hidden = false
        fade(slowHintLabel, toVisible: false)
        
        logoImageView.image = NSImage(named: result ? "logo-baidu" : "logo-baidu-disabled")
        statusLabel.stringValue = result ? "Connection established" : "No connection"
        messageLabel.stringValue = result ? "You can now surf the Internet liberally." : "There is something happened that\nyou cannot reach the Internet, try fixing it."
    }

}

