//
//  Utils.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/15.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

typealias Cancellable = () -> Void

func delay(seconds secs: Double, block: () -> Void) -> Cancellable {
    var cancelled = false
    
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * secs))
    dispatch_after(time, dispatch_get_main_queue()) { 
        if !cancelled {
            block()
        }
    }
    
    return {
        cancelled = true
    }
}

func delayWithoutCancellable(seconds secs: Double, block: () -> Void) {
    let _ = delay(seconds: secs, block: block)
}

func fade(view: NSView, toVisible visible: Bool) {
    NSAnimationContext.beginGrouping()
    NSAnimationContext.currentContext().duration = 0.4
    view.animator().alphaValue = visible ? 1.0 : 0.0
    NSAnimationContext.endGrouping()
}