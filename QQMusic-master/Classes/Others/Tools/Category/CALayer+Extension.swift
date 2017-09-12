//
//  CALayer+Extension.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
extension CALayer{
    //暂停layer动画
    func pauseAnimate(){
        let pausedTime: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    //开始动画
    func resumeAnimate(){
        let pausedTime :CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
    }
}
