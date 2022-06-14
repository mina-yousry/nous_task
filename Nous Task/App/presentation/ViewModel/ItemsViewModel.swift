//
//  ItemsViewModel.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import RxRelay

class ItemsViewModel: BaseViewModel<Repo,
                                    ItemsControllerRoutes,
                                    ItemsCoordinator> {
    
    //MARK: - output
    var items = BehaviorRelay<[Item]>(value: [])
    
    required init(coordinator: ItemsCoordinator?) {
        super.init(coordinator: coordinator)
        self.repo.response
            .map{ $0.items }
            .bind(to: items)
            .disposed(by: disposeBag)
        self.repo.getData()
    }
}
