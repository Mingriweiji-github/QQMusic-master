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
    var filename :String?
    var lrcname :String?
    var singer:String?
    var singerIcon:String?
    var icon:String?
    
    override init() {
        super.init()
    }
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    //注释此处：model无效
//    override func setValue(_ value: Any?, forKey key: String) {}    
    //如果重写setValue(_ value: Any?, forUndefinedKey key: 方法，在使用kvc对类的属性赋值时，字典中有的字段可以在类中没有对应的属性值。
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    //    注释此处：setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key lrcname.

}
