//
//  GetDataRequest.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation

class GetDataRequest: BaseRemoteRequest<Api> {
    
    init() {
        let req = Api.items
        super.init(requset: req, provider: Providers.apiProvider)
    }
}
