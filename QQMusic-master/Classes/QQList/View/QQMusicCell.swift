//
//  QQMusicCell.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/11.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class QQMusicCell: UITableViewCell {

    @IBOutlet weak var headerImageV: UIImageView!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
