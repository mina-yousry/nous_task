//
//  KoinzRequest.swift
//  Koinz
//
//  Created by Mina Yousry on 02/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import Moya

class BaseRemoteRequest <T: BaseTarget> {
    
    var requset: T
    var provider: MoyaProvider<T>
    
    init(requset: T,
         provider: MoyaProvider<T>) {
        self.requset = requset
        self.provider = provider
    }
}

protocol BaseTarget: Silenceable {
    var name: String { get }
}

extension BaseTarget {
    
    func getRequestHeaders () -> [String: String] {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let vendorID = Environment.VENDOR_ID
        let appVersion = Environment.APP_VERSION
        let appVersionCode = Environment.APP_VERSION_CODE
        let appLanguage = Environment.APP_LANGUAGE
        let adId = Environment.ADID

        let headers = [
            "token": token,
            "installation-id": vendorID,
            "version-name": appVersion,
            "version-code": appVersionCode,
            "version": appVersion, // MARK: To be deprecated later
            "device-type": "ios",
            "app-lang": appLanguage,
            "ad-id": adId]
        return headers
    }
}

enum FetchStrategy {
    case onlineOnly
    case offlineOnly
    case offlineThenOnline
}

enum CacheStrategy {
    case none
    case perSession
    case permanentCache
}
