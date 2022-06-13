//
//  BaseRepo.swift
//  Koinz
//
//  Created by Mina Yousry on 02/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import Moya
import RxRelay
import RxSwift

protocol BaseRemoteDataSourceProtocol {
    associatedtype RequestTargetType: BaseTarget
    var remoteFetcher: RemoteFetcher { get set }
    var disposeBag: DisposeBag { get }
    func getOnlineResponse
    <R: BaseResponse, T: BaseTarget>(request: BaseRemoteRequest<T>,
                                     responseObservable: PublishRelay<R>)
}

extension BaseRemoteDataSourceProtocol {
    func getOnlineResponse
    <R: BaseResponse, T: BaseTarget>(request: BaseRemoteRequest<T>,
                                     responseObservable: PublishRelay<R>) {
        self.remoteFetcher.getRemoteResponse(request: request,
                                             responseObservable: responseObservable)
    }
}

class BaseRemoteDataSource<T: BaseTarget>: BaseRemoteDataSourceProtocol {
    
    typealias RequestTargetType = T
    
    var remoteFetcher: RemoteFetcher
    var disposeBag: DisposeBag
    
    init(repo: BaseRepo?) {
        self.disposeBag = DisposeBag()
        self.remoteFetcher = RemoteFetcher(loading: repo?.isLoading,
                                           error: repo?.error)
    }
}

class BaseLocalDataSource {
    
    var localFetcher: LocalFetcher
    
    init() {
        self.localFetcher = LocalFetcher()
    }
}

enum RepoError {
    case generic
    case noConnection
    case invalidToken
    case server
    case parsing
    case emptyResponse
    case backEnd(code: Int, body: [String: Any], name: String)
}
