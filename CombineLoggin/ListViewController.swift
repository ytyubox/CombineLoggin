//
//  ListViewController.swift
//  CombineLoggin
//
//  Created by 游宗諭 on 2019/10/11.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit
import Combine
import CombineDataSources

class ListViewConcroller: UIViewController,Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    var resourcePublisher : Just<[String]>!
    var set = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        resourcePublisher.bind(subscriber:
            (tableView.rowsSubscriber(cellIdentifier: "Cell", cellType: UITableViewCell.self) { (cell, indexPath, model) in
                cell.textLabel?.text = model
            })
        )
            .store(in: &set)
    }
}
