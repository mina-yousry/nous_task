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

    //MARK: - IBOutlets
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Bindable Type
    override func initializeViews() {
        super.initializeViews()
        self.title = "Items"
        self.itemsTableView.register(UINib(nibName: "ITemTableViewCell", bundle: nil), forCellReuseIdentifier: "ITemTableViewCell")
        itemsTableView.estimatedRowHeight = UITableView.automaticDimension
        itemsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        bindTableViewItems()
        bindNoDataView()
        bindTableViewSelection()
        bindSearchText()
    }
    
    //MARK: - Private Methods
    private func bindTableViewItems() {
        self.viewModel?.items
            .asDriver(onErrorJustReturn: [])
            .drive(self.itemsTableView.rx.items){ (tableView, index, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ITemTableViewCell") as! ITemTableViewCell
            cell.setData(item: item)
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func bindNoDataView() {
        self.viewModel?.items.skip(1).subscribe(onNext: { [weak self] items in
            if items.count == 0 {
                self?.addNoDataView()
            } else {
                self?.removeNoDataView()
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func bindTableViewSelection() {
        self.itemsTableView.rx.modelSelected(Item.self).subscribe(onNext: { [weak self] item in
            self?.viewModel?.router.accept(.sendEmail(title: item.title, body: item.itemDescription))
        }).disposed(by: disposeBag)
    }
    
    private func addNoDataView() {
        let noDataView = UINib(nibName: "NoDataView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        self.itemsTableView.backgroundView = noDataView
    }
    
    private func removeNoDataView() {
        itemsTableView.backgroundView = nil
    }
    
    private func bindSearchText() {
        if let searchText = self.viewModel?.searchText {
            self.searchField.rx.textChanged.throttle(RxTimeInterval.milliseconds(50), scheduler: MainScheduler.instance).bind(to: searchText).disposed(by: disposeBag)
        }
    }
}
