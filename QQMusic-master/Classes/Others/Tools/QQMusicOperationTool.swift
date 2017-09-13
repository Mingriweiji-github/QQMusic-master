//
//  QQMusicOperationTool.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import MediaPlayer

class QQMusicOperationTool: NSObject {
    //单例
    static let sharedInstance = QQMusicOperationTool()
    let tool = QQMusicTool()
    var musicMs:[QQMusicModel] = [QQMusicModel]()
    
    fileprivate var lastRow = -1
    fileprivate var artWork: MPMediaItemArtwork?
    
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
    
    fileprivate var musicMessageM = QQMusicMessageModel()
    func getMusicMessageM()-> QQMusicMessageModel{
        musicMessageM.musicM = musicMs[currentPlayIndex]
        musicMessageM.costTime = tool.player?.currentTime ?? 0
        musicMessageM.totalTime = tool.player?.duration ?? 0
        musicMessageM.isPlaying = tool.player?.isPlaying ?? false
        return musicMessageM
    }
    
    func playMusic(_ musicM:QQMusicModel){
        guard musicM.filename != nil else {
            return
        }
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
    func setupLockMessage() {
        let messageM = getMusicMessageM()
        let center = MPNowPlayingInfoCenter.default()
        
        let musicName = messageM.musicM?.name ?? ""
        let singer = messageM.musicM?.singer ?? ""
        let costTime = messageM.costTime
        let totalTime = messageM.totalTime
        
        let lrcFileName = messageM.musicM?.filename
        let lrcMs = QQMusicDataManager.getLrcs(lrcFileName)
        let lrcCurrent = QQMusicDataManager.getCurrentLrcModel(messageM.costTime, lrcMs: lrcMs)
        let lrcM = lrcCurrent.lrcM
        
        var resultImage:UIImage?
        if lastRow != lrcCurrent.row {
            lastRow = lrcCurrent.row
            resultImage = QQImageTool.getNewImage(UIImage(named:messageM.musicM?.icon ?? ""), sourcStr: lrcM?.lrcContent)
            if resultImage != nil{
                //锁屏照片
                artWork = MPMediaItemArtwork(image: resultImage!)
            }
        }
        
        let dict:NSMutableDictionary = [
            MPMediaItemPropertyAlbumTitle:musicName,
            MPMediaItemPropertyArtist:singer,
            MPMediaItemPropertyPlaybackDuration:totalTime,
            MPNowPlayingInfoPropertyElapsedPlaybackTime:costTime
        ]
        
        if artWork != nil {
            dict.setValue(artWork!, forKey: MPMediaItemPropertyArtwork)
        }
        let dicCopy = dict.copy()
        center.nowPlayingInfo = dicCopy as? [String:Any]
        //开启远程控制
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    
}
