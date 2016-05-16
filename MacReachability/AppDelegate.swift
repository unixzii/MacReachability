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

    var popover: NSPopover!
    var statusItem: NSStatusItem!
    
    var eventMonitor: AnyObject?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.setActivationPolicy(.Accessory)
        
        NSDistributedNotificationCenter.defaultCenter().addObserver(self, selector: #selector(makeStatusItem), name: "AppleInterfaceThemeChangedNotification", object: nil)
        
        popover = NSPopover()
        popover.contentViewController = PopoverViewController(nibName: "PopoverView", bundle: nil)
        
        makeStatusItem()
    }
    
    func applicationWillTerminate(notification: NSNotification) {
        NSStatusBar.systemStatusBar().removeStatusItem(statusItem)
        statusItem = nil
    }
    
    func makeStatusItem() {
        if statusItem == nil {
            statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
            statusItem.button?.action = #selector(showPopover)
        }
        
        let style = NSUserDefaults.standardUserDefaults().stringForKey("AppleInterfaceStyle")
        let iconName = style == "Dark" ? "icon-status-item" : "icon-status-item-dark"
        
        statusItem.button?.image = NSImage(named: iconName)
        statusItem.button?.alternateImage = NSImage(named: iconName)
    }
    
    func showPopover() {
        if popover.shown {
            hidePopover()
            return
        }
        
        if let button = statusItem.button {
            popover.showRelativeToRect(button.frame, ofView: button, preferredEdge: .MinY)
            
            eventMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask([.LeftMouseDownMask, .RightMouseDownMask]) { event in
                self.hidePopover()
            }
        }
    }
    
    func hidePopover() {
        if popover.shown {
            popover.close()
            
            if self.eventMonitor != nil {
                NSEvent.removeMonitor(self.eventMonitor!)
                self.eventMonitor = nil
            }
        }
    }
    
}

