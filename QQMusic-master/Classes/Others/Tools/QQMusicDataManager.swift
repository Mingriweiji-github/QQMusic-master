//
//  QQMusicDataManager.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/11.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQMusicDataManager: NSObject {
    class func getMusics(_ result: ([QQMusicModel])-> ()){
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            result([QQMusicModel]())
            return
        }
        
        
        guard let array = NSArray(contentsOfFile: path) else {
            result([QQMusicModel]())
            return
        }
        
        var musics = [QQMusicModel]()
        for dict in array {
            //转model
            let musicM = QQMusicModel(dict:dict as! [String:Any])
            //model数组拼接
            musics.append(musicM)
        }
        
        result(musics)
    }
    class func getLrcs(_ lrcName:String?) -> [QQLrcModel] {
        if lrcName == nil {
            return [QQLrcModel]()
        }
        guard let path = Bundle.main.path(forResource: lrcName, ofType: nil) else {
            return [QQLrcModel]()
        }
        var lrcContent = "" //字符串
        do {
            lrcContent = try String(contentsOfFile: path)
            
        } catch  {
            print(error)
            return [QQLrcModel]()
        }
        let timeContentArray = lrcContent.components(separatedBy: "\n")
        var lrcModelS = [QQLrcModel]()
        for timeStr in timeContentArray {
            if timeStr.contains("[ti:") || timeStr.contains("[ar:") || timeStr.contains("[al:") {
                continue
            }
            let resutlLrcStr = timeStr.replacingOccurrences(of: "[", with: "")
            let timeAndContent = resutlLrcStr.components(separatedBy: "]")
            if timeAndContent.count != 2 {continue}
            let time = timeAndContent[0]
            let content = timeAndContent[1]
            let lrcModel = QQLrcModel()
            lrcModel.beginTime = QQTimeTool.getTimeInterval(time)
            lrcModel.lrcContent = content
            lrcModelS.append(lrcModel)
        }
        for index in 0..<lrcModelS.count{
            if index == lrcModelS.count - 1 {break}
            lrcModelS[index].endTime = lrcModelS[index + 1].beginTime
        }
        return lrcModelS
    }
    
   class func getCurrentLrcModel(_ currentTime:TimeInterval,lrcMs:[QQLrcModel]) -> (row:Int,lrcM:QQLrcModel?){
        for i in 0..<lrcMs.count {
            if currentTime > lrcMs[i].beginTime && currentTime < lrcMs[i].endTime {
                return (i,lrcMs[i])
            }
        }
        return (0,nil)
    }
    
    
}
