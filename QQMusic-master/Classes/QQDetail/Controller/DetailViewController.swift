//
//  DetailViewController.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var lrcScrollView: UIScrollView!
    @IBOutlet weak var lrcLabel: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //volume
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        
        QQMusicOperationTool.sharedInstance.volume(sender.value)
    }
    
    //UISlide事件
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("Tap")
//        let value = sender.location(in: sender.view).x / (sender.view?.width)!
//        progressSlider.value = Float(value)
//        let totalTime = QQMusicOperationTool.sharedInstance.
    }
    @IBAction func touchUp(_ sender: UISlider) {
        
    }
    @IBAction func touchDown(_ sender: Any) {
    }
    
    @IBAction func valueChanged() {
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
    }
    @IBAction func playOrPauseAction(_ sender: Any) {
    }

    @IBAction func preMusicAction(_ sender: Any) {
    }
    @IBAction func nextMusicAction(_ sender: Any) {
    }
    
    @IBAction func backward(_ sender: UIButton) {
    }

    @IBAction func foreward(_ sender: UIButton) {
    }
        /*Timer*/
    func addTimer(){
    
        updateTimer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimes), userInfo: nil, repeats: true)
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
    
    /*
     Update Actions
     */
    func updateTimes(){
        let messageM = QQMusicOperationTool.sharedInstance.getMusicMessageM()
        progressSlider.value = Float(messageM.costTime / messageM.totalTime)
        //??????????
        costTimeLabel.text = messageM.costTimeFormat//QQTimeTool.getFormateTime(messageM.costTime)
        playOrpauseBtn.isSelected = messageM.isPlaying
    }
    func updateLrc(){
        let messageM = QQMusicOperationTool.sharedInstance.getMusicMessageM()
        let time = messageM.costTime
        let rowLrc = QQMusicDataManager.getCurrentLrcModel(time, lrcMs: lrcVC.lrcMs)
        let lrcM = rowLrc.lrcM
        lrcLabel.text = lrcM?.lrcContent
        if lrcM != nil {
//            lrcLabel. = CGFloat(time - lrcM?.beginTime) / (lrcM?.endTime - lrcM?.beginTime)
        }
        
        
    
    }
    
}
