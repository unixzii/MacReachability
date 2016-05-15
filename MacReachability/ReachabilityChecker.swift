//
//  ReachabilityChecker.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/15.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

class ReachabilityChecker: NSObject {

    class func checkInBackgroundWithBlock(block: (Bool) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: "https://www.baidu.com/")!) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if (response as? NSHTTPURLResponse)?.statusCode == 200 {
                    block(true)
                } else {
                    block(false)
                }
            }
        }
        
        task.resume()
    }
    
}
