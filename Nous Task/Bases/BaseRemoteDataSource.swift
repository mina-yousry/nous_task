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

protocol RemoteDataSourceProtocol {
    associatedtype RequestTargetType: BaseTarget
    var remoteFetcher: RemoteFetcher { get set }
    var disposeBag: DisposeBag { get }
    func getOnlineResponse
    <R: BaseResponse, T: BaseTarget>(request: BaseRemoteRequest<T>,
                                     responseObservable: PublishSubject<R>)
}

class BaseRemoteDataSource<T: BaseTarget>: RemoteDataSourceProtocol {
    
    typealias RequestTargetType = T
    
    var remoteFetcher: RemoteFetcher
    var disposeBag: DisposeBag = DisposeBag()
    
    init(repo: BaseRepo?) {
        self.remoteFetcher = RemoteFetcher(loading: repo?.isLoading,
                                           error: repo?.error)
    }
    
    func getOnlineResponse
    <R: BaseResponse, T: BaseTarget>(request: BaseRemoteRequest<T>,
                                     responseObservable: PublishSubject<R>) {
        self.remoteFetcher.getRemoteResponse(request: request,
                                             responseObservable: responseObservable)
    }
}

enum RepoError: Error {
    case generic
    case noConnection
    case server
    case parsing
}
