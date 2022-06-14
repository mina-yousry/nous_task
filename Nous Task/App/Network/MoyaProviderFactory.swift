//
//  MoyaProviderFactory.swift
//  Koinz
//
//  Created by Koinz on 07/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import Moya
import SwiftUI

enum ProviderEnvironment {
    case online
    case local(delay: TimeInterval = 0)
}

class MoyaPrviderFactory<T: BaseTarget> {
    typealias ProviderType = MoyaProvider<T>
    
    func create(env: ProviderEnvironment = .online) -> ProviderType {
        // If XCTests are running use the local source
        if NSClassFromString("XCTest") != nil {
            return createLocalProvider(delay: 0)
        } else {
            switch env {
            case .online:
                return createOnlineProvider()
            case .local(let delay):
                return createLocalProvider(delay: delay)
            }
        }
    }
    
    func createLocalProvider(delay: TimeInterval) -> ProviderType {
        let provider = MoyaProvider<T>.init(stubClosure: {_ in 
            return StubBehavior.immediate
        })
        return provider
    }
    
    func createOnlineProvider() -> ProviderType {
        let provider = MoyaProvider<T>.init()
        return provider
    }
}
