//
//  ItemsViewController.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemsViewController: BaseViewController<ItemsViewModel> {

    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initializeViews() {
        super.initializeViews()
        self.title = "Items"
        self.itemsTableView.register(UINib(nibName: "ITemTableViewCell", bundle: nil), forCellReuseIdentifier: "ITemTableViewCell")
        itemsTableView.estimatedRowHeight = UITableView.automaticDimension
        itemsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        self.viewModel?.items.bind(to: self.itemsTableView.rx.items){ (tableView, index, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ITemTableViewCell") as! ITemTableViewCell
            cell.setData(item: item)
            return cell
        }.disposed(by: disposeBag)
        self.itemsTableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.viewModel?.router.accept(.sendEmail(title: item.title, body: item.itemDescription))
        }).disposed(by: disposeBag)
        self.searchField.rx.
    }
}
