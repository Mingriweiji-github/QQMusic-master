//
//  QQImageTool.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/13.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQImageTool: NSObject {

    class func getNewImage(_ sourcImage:UIImage?,sourcStr:String?) -> UIImage?{
    
        guard let image = sourcImage else { return nil }
        guard let resultStr = sourcStr else { return image}
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let textAttribute = [
        
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 18),
            NSParagraphStyleAttributeName:style

        ]
        
        let textRect = CGRect(x: 0, y: 0, width: image.size.width, height: 28)
        (resultStr as NSString).draw(in: textRect, withAttributes: textAttribute)
        
        let resutImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resutImage
    }
}
