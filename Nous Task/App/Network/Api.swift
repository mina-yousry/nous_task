//
//  Api.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import Moya

enum Api {
    case items
}

extension Api: BaseTarget {
    var baseURL: URL {
        return URL(string: "https://cloud.nousdigital.net")!
    }
    
    var path: String {
        return "/s/rNPWPNWKwK7kZcS/download"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        guard let data = MockupUtility().getMockDataFor(request: self.name) else {
            return Data()
        }
        return data
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var name:String {
        return "items_request"
    }
}
