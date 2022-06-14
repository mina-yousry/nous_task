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
    
    var allItems: [Item] = []
    //MARK: - input
    var searchText = PublishRelay<String>()
    
    //MARK: - output
    var items = BehaviorRelay<[Item]>(value: [])
    
    required init(coordinator: ItemsCoordinator?) {
        super.init(coordinator: coordinator)
        let itemsObservable = self.repo.response.map{ $0.items }.share()
        itemsObservable.bind(to: items).disposed(by: disposeBag)
        itemsObservable.subscribe(onNext: { [weak self] items in
            self?.allItems = items
        }).disposed(by: disposeBag)
        self.repo.getData()
        searchText.subscribe(onNext: { [weak self] text in
            if text == "" {
                self?.items.accept(self?.allItems ?? [])
            } else {
                let tempItems = self?.allItems
                let filteredItems = tempItems?.filter{ $0.title.lowercased().contains(text.lowercased()) || $0.itemDescription.lowercased().contains(text.lowercased()) }
                self?.items.accept(filteredItems ?? [])
            }
        }).disposed(by: disposeBag)
    }
}
