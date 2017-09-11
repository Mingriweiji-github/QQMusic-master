//
//  QQTimeTool.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/11.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {

   class func getFormateTime(_ timeInterVal:TimeInterval) -> String {
        return String(format: "%02d:%02d", Int(timeInterVal) / 60,Int(timeInterVal) % 60)
    }
   class func getTimeInterval(_ formatTime:String) -> TimeInterval {
        let minSec = formatTime.components(separatedBy: ":")
        if minSec.count != 2 {
            return 0
        }
        let min = TimeInterval(minSec[0]) ?? 0.0
        let sec = TimeInterval(minSec[1]) ?? 0.0
        return min * 60.0 + sec
    }
}
