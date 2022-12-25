//
//  KoinzRequest.swift
//
//  Created by Mina Yousry on 02/02/2022.
//  Copyright © 2022 Mina Yousry. All rights reserved.
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

protocol BaseTarget: TargetType {}
