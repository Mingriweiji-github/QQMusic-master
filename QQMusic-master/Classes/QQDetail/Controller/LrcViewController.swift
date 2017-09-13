//
//  LrcViewController.swift
//  QQMusic-master
//
//  Created by M_Li on 2017/9/12.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class LrcViewController: UITableViewController {

    var progress: CGFloat = 0{
    
        didSet{
        
            let cell = tableView.cellForRow(at: IndexPath(row: scrollRow, section: 0)) as? LrcCell
            cell?.progress = progress
        }
    }
    var scrollRow = -1{
        didSet{
            if scrollRow == oldValue {
                return
            }
            tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.fade)
            tableView.scrollToRow(at:IndexPath(row: scrollRow, section: 0), at: UITableViewScrollPosition.middle, animated: true)
            
        }
    }
    
    var lrcMs: [QQLrcModel] =  [QQLrcModel](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsetsMake(tableView.height * 0.5, 0, tableView.height * 0.5, 0)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcMs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LrcCell.cellwithTableView(tableView)
        if indexPath.row == scrollRow {
            cell.progress = progress
        }else{
            cell.progress = 0
        }
        
        cell.lrcContent = lrcMs[indexPath.row].lrcContent
        return cell
    }

}
