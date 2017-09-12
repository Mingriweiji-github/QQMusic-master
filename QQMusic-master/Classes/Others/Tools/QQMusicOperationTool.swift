//
//  QQMusicOperationTool.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQMusicOperationTool: NSObject {
    //单例
    static let sharedInstance = QQMusicOperationTool()
    let tool = QQMusicTool()
    var musicMs = [QQMusicModel]()
    
    fileprivate var currentPlayIndex = -1{
        didSet{
            if currentPlayIndex < 0 {
                currentPlayIndex = musicMs.count - 1
            }
            if currentPlayIndex > musicMs.count - 1 {
                currentPlayIndex = 0
            }
        }
    }
    func playMusic(_ musicM:QQMusicModel){
        
        tool.playMusic(musicM.filename!)
        currentPlayIndex = musicMs.index(of: musicM)!
    }
    func playCurrentMusic() {
        playMusic(musicMs[currentPlayIndex])
    }
    func pauseCurrentMusic(){
        tool.pauseMusic()
    }
    func nextMusic(){
        currentPlayIndex += 1
        let model = musicMs[currentPlayIndex]
        playMusic(model)
    }
    func preMusic(){
    
        currentPlayIndex -= 1
        let model = musicMs[currentPlayIndex]
        playMusic(model)
    }
    func jumpTo(_ time:TimeInterval){
    
        tool.jumpToTime(time)
    }
    func forward(){
        
        tool.fastforward(5)
    }
    func backward(){
        tool.fastBack(5)
    }
    func volume(_ value:Float){
        tool.volume(value)
    }
    
    //锁屏信息
    
}
