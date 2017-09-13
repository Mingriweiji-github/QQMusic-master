//
//  LrcLabel.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class LrcLabel: UILabel {

    //单行歌词进度
    var radio : CGFloat = 0.0{
    
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor.green.set()
        
        //进度
        UIRectFillUsingBlendMode(CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * radio, height: rect.size.height), CGBlendMode.sourceIn)
    }
}
