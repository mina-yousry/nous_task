//
//  OnlineFetcher.swift
//
//  Created by Mina Yousry on 02/02/2022.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import Alamofire
import Moya

class RemoteFetcher {
    
    var error: PublishRelay<RepoError>?
    var loading: PublishRelay<Bool>?
    private var isConnectedToInternet: Bool {
        if !(Connectivity.isConnectedToInternet()) {
            error?.accept(.noConnection)
            return false
        }
        return true
    }
    
    init(loading: PublishRelay<Bool>?, error: PublishRelay<RepoError>?) {
        self.loading = loading
        self.error = error
    }
    
    func getRemoteResponse
        <T: BaseTarget, R: BaseResponse>(request: BaseRemoteRequest<T>,
                                         responseObservable: PublishSubject<R>?) {
        if isConnectedToInternet {
            self.loading?.accept(true)
            request.provider.request(request.requset) { [weak self] (result) in
                self?.loading?.accept(false)
                switch result {
                case .success(let response):
                    let decoder: JSONDecoder = JSONDecoder()
                    do {
                        let decodedResponse = try decoder.decode(R.self, from: response.data)
                        responseObservable?.onNext(decodedResponse)
                    } catch _ {
                        self?.error?.accept(.parsing)
                        responseObservable?.onError(RepoError.parsing)
                    }
                case .failure(let error):
                    guard let statusCode = error.response?.statusCode
                        else {
                            self?.error?.accept(.generic)
                            responseObservable?.onError(RepoError.generic)
                            return
                    }
                    switch statusCode {
                    case 500:
                        self?.error?.accept(.server)
                        responseObservable?.onError(RepoError.server)
                    default:
                        self?.error?.accept(.generic)
                        responseObservable?.onError(RepoError.generic)
                    }
                }
            }
        }
    }
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        if let networkManager = NetworkReachabilityManager() {
            return networkManager.isReachable
        } else {
            return false
        }
    }
}
