//
//  OnlineFetcher.swift
//  Koinz
//
//  Created by Mina Yousry on 02/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import RxRelay
import Moya

class RemoteFetcher {
    
    var error: PublishRelay<RepoError>?
    var loading: PublishRelay<Bool>?
    private var isConnectedToInternet: Bool {
        if !(Connectivity.isConnectedToInternet()) {
            sendNoInternetEvent()
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
                                     responseObservable: PublishRelay<R>) {
        if isConnectedToInternet {
            self.loading?.accept(true)
            request.provider.request(request.requset) { [weak self] (result) in
                self?.loading?.accept(false)
                switch result {
                case .success(let response):
                    
                    if response.statusCode == 204 {
                        self?.error?.accept(.emptyResponse)
                    } else {
                        let decoder: JSONDecoder = JSONDecoder()
                        do {
                            let decodedResponse = try decoder.decode(R.self, from: response.data)
                            self?.logSuccessRequest(request: request,
                                                    decodedResponse: decodedResponse)
                            responseObservable.accept(decodedResponse)
                        } catch let error {
                            print(error)
                            self?.logFaliedRequset(request: request,
                                                  responseDescription: response.description,
                                                  errorDescription: error.localizedDescription)
                            self?.error?.accept(.parsing)
                        }
                    }
                case .failure(let error):
                    guard let statusCode = error.response?.statusCode
                    else {
                        self?.error?.accept(.generic)
                        return
                    }
                    switch statusCode {
                    case 401:
                        self?.error?.accept(.invalidToken)
                    case 500:
                        self?.error?.accept(.server)
                    default:
                        if let errorResponse = try? error.response?.mapJSON() as? [String: Any] {
                            self?.error?.accept(.backEnd(code: statusCode,
                                                         body: errorResponse,
                                                         name: request.requset.name))
                        } else if let errorResponse = try? error.response?.map(String.self) {
                            let body = ["err_message": errorResponse]
                            self?.error?.accept(.backEnd(code: statusCode,
                                                         body: body,
                                                         name: request.requset.name))
                        }
                        
                    }
                }
            }
        }
    }
    
    private func logSuccessRequest
    <T: BaseTarget, R: BaseResponse>(request: BaseRemoteRequest<T>,
                                     decodedResponse: R) {
        AnalyticsManager.shared.trackEvent(event: .requestDidSucceed, payload: [
            AnalyticsPropertyNames.link.rawValue: request.requset.path
        ])
    }
    
    private func logFaliedRequset
    <T: BaseTarget>(request: BaseRemoteRequest<T>,
                    responseDescription: String,
                    errorDescription: String) {
        AnalyticsManager.shared.trackEvent(event: .responseParsingFailed, payload: [
            AnalyticsPropertyNames.link.rawValue: request.requset.path,
            AnalyticsPropertyNames.responseJSON.rawValue: responseDescription,
            AnalyticsPropertyNames.parsingException.rawValue: errorDescription
        ])
    }
    
    private func sendNoInternetEvent() {
        AnalyticsManager.shared.trackEvent(event: .problemWithAnInternetConnection,
                                           payload: [:])
    }
}
