//
//  BaseViewModel.swift
//
//  Created by Mina Yousry on 25/01/2022.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

protocol ViewModelType: AnyObject {
    
    var isLoading: BehaviorRelay<Bool> { get }
    var error: PublishRelay<RepoError> { get }
    func close()
    func handleError(_ error: RepoError)
    func handleBackendError(code: Int, body: [String: Any], name: String)
    
}

class BaseViewModel<RepoType: BaseRepo,
                    RouteType: BaseRouterProtocol,
                    CoordinatorType: BaseCoordinator<RouteType>>: ViewModelType {
    
    var repo: RepoType
    weak var coordinator: CoordinatorType?
    var isLoading = BehaviorRelay<Bool>(value: false)
    var router = PublishRelay<RouteType>()
    var error = PublishRelay<RepoError>()
    let disposeBag = DisposeBag()
    
    required init(coordinator: CoordinatorType?) {
        self.repo = RepoType.init()
        self.coordinator = coordinator
        let repoDisposeBag = self.repo.disposeBag
        self.repo.isLoading.bind(to: self.isLoading).disposed(by: repoDisposeBag)
        self.repo.error.bind(to: self.error).disposed(by: repoDisposeBag)
        self.repo.error.subscribe(onNext: { [weak self] error in
            self?.handleError(error)
        }).disposed(by: repoDisposeBag)
        if let router = coordinator?.router {
            self.router.bind(to: router).disposed(by: disposeBag)
        }
    }
    
    func close() {
        self.coordinator?.close()
    }
    
    func handleError(_ error: RepoError) {}
    
    func handleBackendError(code: Int, body: [String: Any], name: String) {}
}
