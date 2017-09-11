//
//  QQMusicModel.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/11.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {

    var name:String?
    var fileName :String?
    var lrcName :String?
    var singer:String?
    var singerImage:String?
    var icon:String?
    
    override init() {
        super.init()
    }
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
    }
    
    
}
