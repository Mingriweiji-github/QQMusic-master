//
//  QQMusicListController.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/11.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQMusicListController: UITableViewController {
    var models:[QQMusicModel] = [QQMusicModel](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        //Model
        
        QQMusicDataManager.getMusics { (musicModels:[QQMusicModel]) in
            self.models = musicModels
            self.tableView.reloadData()
        }
    }

    func setupUI(){
        tableView.rowHeight = 60
        tableView.backgroundView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        tableView.separatorStyle = .none
        let nib = UINib(nibName: String(describing:QQMusicCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "musicCellID")
        //隐藏下一级导航栏
        navigationController?.isNavigationBarHidden = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "musicCellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! QQMusicCell
        cell.musicModel = models[indexPath.row]
        //设置关键帧缩放动画
        cell.animation(AnimationType.scale)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        QQMusicOperationTool.sharedInstance.musicMs = models
        QQMusicOperationTool.sharedInstance.playMusic(models[(indexPath as NSIndexPath).row])
        performSegue(withIdentifier: "listToDetail", sender: nil)
        
    }

}
