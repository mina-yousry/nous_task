//
//  Repo.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import RxSwift

class Repo: BaseRepo {
    
    var response = PublishSubject<ItemsRsponse>()
    var dataSource: DataSource?
    
    required init() {
        super.init()
        dataSource = DataSource(repo: self)
    }
    
    func getData() {
        self.dataSource?.getData()
    }
}
