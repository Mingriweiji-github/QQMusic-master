//
//  QQMusicTool.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import AVFoundation

let kPlayFinishNotification = "kPlayFinishNotification"

class QQMusicTool: NSObject {

    var player:AVAudioPlayer?
    var volume:Float = 1
    
    override init() {
        super.init()
        //初始化是添加setCategory和setActive,Info.plist中添加
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)//后台播放
            try session.setActive(true)
        } catch  {
            print(error)
            return
        }
    }
    
    func playMusic(_ musicName:String) {
        
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else { return }
        if player?.url == url {
            player?.play()
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.enableRate = true
            player?.prepareToPlay()
            player?.volume = volume
            player?.play()
            
        } catch {
            print(error)
            return
        }
    }
    func jumpToTime(_ time:TimeInterval){
        player?.currentTime = time
    }
    func pauseMusic(){
        player?.pause()
    }
    func playCurrent(){
        player?.play()
    }
    func stopCurrent(){
        player?.currentTime = 0
        player?.stop()
    }
    func fastforward(_ value:TimeInterval){
        player?.currentTime += value
    }
    func fastBack(_ value:TimeInterval){
        player?.currentTime -= value
    }
    //播放速率: 1.0 is normal, 0.5 is half speed, 2.0 is double speed
    func rate(_ value:Float){
        player?.rate = value
    }
    //音量
    func volume(_ value:Float){
        volume = value
        player?.volume = volume
    }
    
    
}

extension QQMusicTool : AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: kPlayFinishNotification), object: nil)
    }
}
