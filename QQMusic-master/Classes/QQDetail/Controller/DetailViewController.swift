//
//  DetailViewController.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var backImageV: UIImageView!
    @IBOutlet weak var foreImageV: UIImageView!
    
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var lrcScrollView: UIScrollView!
    @IBOutlet weak var lrcLabel: LrcLabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var costTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playOrpauseBtn: UIButton!
    fileprivate var updateTimer:Timer?
    fileprivate var updateLrcLink:CADisplayLink?
    
    lazy var lrcVC: LrcViewController = {
        return LrcViewController()
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //volume
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        
        QQMusicOperationTool.sharedInstance.volume(sender.value)
    }
    
    //UISlide事件
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("Tap")
        let value = sender.location(in: sender.view).x / (sender.view?.width)!
        progressSlider.value = Float(value)
        
        let totalTime = QQMusicOperationTool.sharedInstance.getMusicMessageM().totalTime
        let costTime = totalTime * TimeInterval(value)
        QQMusicOperationTool.sharedInstance.jumpTo(costTime)
    }
    @IBAction func touchUp(_ sender: UISlider) {
        addTimer()
        let cost = QQMusicOperationTool.sharedInstance.getMusicMessageM().totalTime * TimeInterval(progressSlider.value)
        QQMusicOperationTool.sharedInstance.jumpTo(cost)
        
    }
    @IBAction func touchDown(_ sender: Any) {
        removeTimer()
    }
    
    @IBAction func valueChanged() {
        let cost = QQMusicOperationTool.sharedInstance.getMusicMessageM().totalTime * TimeInterval(progressSlider.value)
        costTimeLabel.text = QQTimeTool.getFormateTime(cost)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func playOrPauseAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            QQMusicOperationTool.sharedInstance.playCurrentMusic()
            foreImageV.layer.resumeAnimate()
        }else{
            QQMusicOperationTool.sharedInstance.pauseCurrentMusic()
            foreImageV.layer.pauseAnimate()
        }
    }

    @IBAction func preMusicAction(_ sender: Any) {
        QQMusicOperationTool.sharedInstance.preMusic()
        updateOnce()
    }
    @IBAction func nextMusicAction(_ sender: Any) {
        QQMusicOperationTool.sharedInstance.nextMusic()
        updateOnce()
    }
    
    @IBAction func backward(_ sender: UIButton) {
        QQMusicOperationTool.sharedInstance.backward()
    }

    @IBAction func foreward(_ sender: UIButton) {
        QQMusicOperationTool.sharedInstance.forward()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lrcVC.tableView.backgroundColor = UIColor.clear
        lrcScrollView.addSubview(lrcVC.tableView)
        lrcScrollView.delegate = self
        lrcScrollView.isPagingEnabled = true
        lrcScrollView.showsHorizontalScrollIndicator = false
        lrcScrollView.showsVerticalScrollIndicator = true
        progressSlider.setThumbImage(UIImage(named:"player_slider_playback_thumb"), for: UIControlState())
        volumeSlider.setThumbImage(UIImage(named:"playing_volumn_slide_sound_icon"), for: UIControlState())
        NotificationCenter.default.addObserver(self, selector: #selector(nextMusicAction(_:)), name: Notification.Name(rawValue:kPlayFinishNotification), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateOnce()
        addTimer()
        addlink()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        removeLink()
    }
    
    
        /*Timer*/
    func addTimer(){
    
        updateTimer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimes), userInfo: nil, repeats: true)
        RunLoop.current.add(updateTimer!, forMode: RunLoopMode.commonModes)
    }
    func removeTimer(){
    
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    /*CADisplayLink*/
    
    func addlink(){
        updateLrcLink = CADisplayLink(target: self, selector: #selector(updateLrc))
        updateLrcLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    func removeLink(){
        updateLrcLink?.invalidate()
        updateLrcLink = nil
    }
    
    /*Update*/
    
    //更新messageM
    func updateOnce(){
    
        let musicMessageM = QQMusicOperationTool.sharedInstance.getMusicMessageM()
        guard let musicM = musicMessageM.musicM else { return }
        if musicM.icon != nil {
            backImageV.image = UIImage(named: musicM.icon!)
            foreImageV.image = UIImage(named: musicM.icon!)
        }
        songLabel.text = musicM.name
        singerLabel.text = musicM.singer
        
        
        //??????????????????
        totalTimeLabel.text = musicMessageM.totalTimeFormat //QQTimeTool.getFormateTime(musicMessageM.totalTime)
        volumeSlider.value = QQMusicOperationTool.sharedInstance.tool.volume
        
        //歌词控制器展示
        lrcVC.lrcMs = QQMusicDataManager.getLrcs(musicM.lrcname)
        //大图旋转动画
        foreImageV.layer.removeAnimation(forKey: "rotation")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        foreImageV.layer.add(animation, forKey: "rotation")
        if musicMessageM.isPlaying {
            foreImageV.layer.resumeAnimate()
        }else{
            foreImageV.layer.pauseAnimate()
        }
    }
    
    func updateTimes(){
        let messageM = QQMusicOperationTool.sharedInstance.getMusicMessageM()
        progressSlider.value = Float(messageM.costTime / messageM.totalTime)
        //??????????
        costTimeLabel.text = messageM.costTimeFormat//QQTimeTool.getFormateTime(messageM.costTime)
        playOrpauseBtn.isSelected = messageM.isPlaying
    }
    //更新频度比updateTimes快60倍，主要用于一行歌词着色进度需求
    func updateLrc(){
        let messageM = QQMusicOperationTool.sharedInstance.getMusicMessageM()
        let time = messageM.costTime
        let rowLrcM = QQMusicDataManager.getCurrentLrcModel(time, lrcMs: lrcVC.lrcMs)
        let lrcM = rowLrcM.lrcM
        lrcLabel.text = lrcM?.lrcContent
        if lrcM != nil {
            lrcLabel.radio = CGFloat((time - lrcM!.beginTime) / (lrcM!.endTime - lrcM!.beginTime))
            lrcVC.progress = lrcLabel.radio
        }
        //整屏中的位置
        lrcVC.scrollRow = rowLrcM.row
        
        //更新锁屏信息
        if UIApplication.shared.applicationState == .background {
            QQMusicOperationTool.sharedInstance.setupLockMessage()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        lrcVC.tableView.frame = lrcScrollView.bounds
        //默认在屏幕的右侧，滚动时出现
        lrcVC.tableView.x = lrcScrollView.width
        //实现滚动
        lrcScrollView.contentSize = CGSize(width: lrcScrollView.width * 2, height: 0)
        foreImageV.layer.cornerRadius = foreImageV.width * 0.5
        foreImageV.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let radio = 1 - scrollView.contentOffset.x / scrollView.width
        foreImageV.alpha = radio
        lrcLabel.alpha = radio
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch (event?.subtype)! {
        case .remoteControlPlay:
            QQMusicOperationTool.sharedInstance.playCurrentMusic()
        case .remoteControlPause:
            QQMusicOperationTool.sharedInstance.pauseCurrentMusic()
        case .remoteControlNextTrack:
            QQMusicOperationTool.sharedInstance.nextMusic()
        case .remoteControlPreviousTrack:
            QQMusicOperationTool.sharedInstance.preMusic()
        default:
            print("remote control Received")
        }
        updateOnce()
    }
    //摇一摇
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        QQMusicOperationTool.sharedInstance.nextMusic()
        updateOnce()
    }
    
    
}
