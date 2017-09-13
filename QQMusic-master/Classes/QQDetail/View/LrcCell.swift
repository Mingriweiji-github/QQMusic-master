//
//  LrcCell.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/13.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class LrcCell: UITableViewCell {
    @IBOutlet weak var lrcLabel: LrcLabel!

    var progress:CGFloat = 0{
        didSet{
            lrcLabel.radio = progress
        }
    }
    var lrcContent:String = ""{
        didSet{
            lrcLabel.text = lrcContent
        }
    }
    class func cellwithTableView(_ tableView:UITableView)->LrcCell{
    
        let cellID = "LRC"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LrcCell
        if cell == nil {
            cell = (Bundle.main.loadNibNamed("LrcCell", owner: nil, options: nil)?.first as? LrcCell)
        }
        return cell!
    }
    
    
    
}
