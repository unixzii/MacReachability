//
//  WindowController.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/15.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.backgroundColor = NSColor.whiteColor()
        window?.titlebarAppearsTransparent = true
        window?.movableByWindowBackground = true
        window?.center()
    }

}
