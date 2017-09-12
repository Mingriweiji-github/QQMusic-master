//
//  QQMusicMessageModel.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {
    var musicM:QQMusicModel?
    var costTime: TimeInterval = 0
    var totalTime: TimeInterval = 0
    var isPlaying: Bool = false
    var costTimeFormat: String {
        get{
            return QQTimeTool.getFormateTime(costTime)
        }
    }
    
    var totalTimeFormat:String {
        get{
            return QQTimeTool.getFormateTime(totalTime)
        }
    }
}
