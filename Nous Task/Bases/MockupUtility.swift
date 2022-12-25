//
//  LocalFetcher.swift
//  Koinz
//
//  Created by Koinz on 08/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import Moya

class MockupUtility {
    static var mockList: [String: String] = ["items_request":"items_v2"]
}

extension MockupUtility {
    static func setFileNameFor(request: String, withFile name: String) {
        MockupUtility.mockList[request] = name
    }
    
    func getMockDataFor(request: String) -> Data? {
        if let fileName = MockupUtility.mockList[request] {
            return getDataFrom(fileName: fileName)
        } else {
            return nil
        }
    }
    
    func getDataFrom(fileName: String, withExtension: String = "json") -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: withExtension)
        else { fatalError("Can't find \(fileName).\(withExtension) file") }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
