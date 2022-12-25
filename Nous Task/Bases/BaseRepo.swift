//
//  BaseRepo.swift
//  Koinz
//
//  Created by Mina Yousry on 03/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

protocol BaseRepoProtocol: AnyObject {
    var error: PublishRelay<RepoError> { get }
    var isLoading: PublishRelay<Bool> { get }
    var disposeBag: DisposeBag { get }
}

class BaseRepo {
    var error = PublishRelay<RepoError>()
    var isLoading = PublishRelay<Bool>()
    let disposeBag = DisposeBag()
    
    required init() {}
}
