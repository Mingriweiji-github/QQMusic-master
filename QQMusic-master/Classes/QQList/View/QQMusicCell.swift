//
//  QQMusicCell.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/11.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
enum AnimationType {
    case rotation
    case transition
    case scale
}

class QQMusicCell: UITableViewCell {

    @IBOutlet weak var headerImageV: UIImageView!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    var musicModel: QQMusicModel? {
        didSet{
            if ((musicModel?.singerImage!) != nil) {
                headerImageV.image = UIImage(named: (musicModel?.singerImage)!)
            }
            singerNameLabel.text = musicModel?.singer
            songNameLabel.text = musicModel?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func animation(_ type:AnimationType){
        if type == .rotation{
            self.layer.removeAnimation(forKey: ".rotation")
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.values = [M_PI,0]
            animation.duration = 0.5
            animation.repeatCount = 1
            self.layer.add(animation, forKey: "rotation")
        }
        if type == .scale{
            self.layer.removeAnimation(forKey: "scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [0.3,0.5,0.8,0.1]
            animation.duration = 1
            animation.repeatCount = 1
            self.layer.add(animation, forKey: "scale")
        }
    }
    
}
