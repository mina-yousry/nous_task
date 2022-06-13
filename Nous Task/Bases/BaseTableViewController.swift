//
//  BaseTableViewController.swift
//  Koinz
//
//  Created by Mina Maged on 02/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import UIKit
import SkeletonView

class BaseTableViewController: BaseViewController {
    let headerRefreshTrigger = PublishSubject<Void>()

    let isHeaderLoading = BehaviorRelay(value: false)
    
    var cellIdentifier: String {
        return ""
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    override func initializeViews() {
        super.initializeViews()
    }
    
    override func startLoading() {
        tableView.dataSource = self
        tableView.showAnimatedGradientSkeleton()
        tableView.startSkeletonAnimation()
    }
    
    override func endLoading() {
        tableView.dataSource = nil
        tableView.hideSkeleton()
    }
}

extension BaseTableViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell()
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
}
