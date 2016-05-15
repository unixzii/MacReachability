//
//  AppDelegate.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/15.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow?
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        showMainWindow(self)
        
        let statusBar = NSStatusBar.systemStatusBar()
        statusItem = statusBar.statusItemWithLength(NSVariableStatusItemLength)
        statusItem.title = "R"
        statusItem.target = self
        statusItem.action = #selector(showMainWindow)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return false
    }
    
    func showMainWindow(sender: AnyObject) {
        if window == nil {
            guard let wc = NSStoryboard(name: "Main", bundle: nil).instantiateControllerWithIdentifier("MainWindow") as? NSWindowController else {
                return
            }
            
            wc.showWindow(sender)
            window = wc.window
        }
        
        window?.makeKeyAndOrderFront(sender)
    }
    
    func closeMainWindow(sender: AnyObject) {
        window?.performClose(sender)
    }
    
}

