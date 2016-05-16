//
//  ReachabilityChecker.swift
//  MacReachability
//
//  Created by 杨弘宇 on 16/5/15.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

import Cocoa

enum ReachabilityCheckerStatus {
    case Pending
    case Failed
    case Succeed
    case Cancelled
}


class ReachabilityChecker: NSObject {

    var URLString: String
    var observer: (ReachabilityCheckerStatus) -> Void
    var task: NSURLSessionTask?
    
    var running: Bool {
        return task != nil
    }
    
    init(URLString: String, observer: (ReachabilityCheckerStatus) -> Void) {
        self.URLString = URLString
        self.observer = observer
        
        super.init()
    }
    
    func start() {
        task?.cancel()
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 5.0
        let session = NSURLSession(configuration: configuration)
        task = session.dataTaskWithURL(NSURL(string: URLString)!) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.task = nil
                
                if (response as? NSHTTPURLResponse)?.statusCode == 200 {
                    self.observer(.Succeed)
                } else {
                    self.observer(.Failed)
                }
            }
        }
        
        task?.resume()
        
        self.observer(.Pending)
    }
    
    func stop() {
        task?.cancel()
        task = nil
        
        self.observer(.Cancelled)
    }
    
}
