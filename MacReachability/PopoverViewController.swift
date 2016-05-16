//
//  PopoverViewController.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/16.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {

    @IBOutlet weak var baiduStatus: NSTextField!
    @IBOutlet weak var googleStatus: NSTextField!
    @IBOutlet weak var progressIndicatior: NSProgressIndicator!
    
    var baiduChecker: ReachabilityChecker!
    var googleChecker: ReachabilityChecker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baiduChecker = ReachabilityChecker(URLString: "https://www.baidu.com/", observer: makeObserverWithStatusLabel(baiduStatus))
        googleChecker = ReachabilityChecker(URLString: "https://www.google.com/", observer: makeObserverWithStatusLabel(googleStatus))
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        progressIndicatior.startAnimation(self)
        
        baiduChecker.start()
        googleChecker.start()
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        baiduChecker.stop()
        googleChecker.stop()
    }
    
    @IBAction func quitButtonDidClick(sender: AnyObject) {
        NSApp.terminate(sender)
    }
    
    func makeObserverWithStatusLabel(statusLabel: NSTextField) -> ((ReachabilityCheckerStatus) -> Void) {
        return { status in
            statusLabel.hidden = false
            
            switch status {
            case .Succeed:
                statusLabel.stringValue = "Connectable"
                break
            case .Failed:
                statusLabel.stringValue = "Not Connectable"
                break
            case .Pending:
                statusLabel.stringValue = "Pending..."
                break
            default:
                statusLabel.hidden = true
            }
            
            if !self.baiduChecker.running && !self.googleChecker.running {
                self.progressIndicatior.stopAnimation(nil)
            }
        }
    }
    
}
