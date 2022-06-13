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
    static var mockList: [String: String] = [
        "getBrands": "getBrands",
        "getAccountType": "RegularAccount",
        "send_verfication_code": "VerificationResponse",
        "verify_verification_code": "VerificationSuccess",
        "regular_signup": "RegularSignup",
        "facebook_signup": "FacebookSignup",
        "google_signup": "GoogleSignup",
        "apple_signup": "AppleSignup",
        "update_customer_data": "UpdateOptionalData",
        "regular_login": "RegularLogin",
        "facebook_login": "FacebookLogin",
        "facebook_login_check": "FacebookLoginCheck",
        "google_login": "GoogleLogin",
        "apple_login": "AppleLogin",
        "reset_password": "ResetPasswordPhoneNumber",
        "delete_account": "DeactivateAccount",
        "check_user_has_mail": "EmailPresent",
        "checkValidMail": "",
        "logout": "Logout",
        "validTopRankedPromotion": "topRankedPromo",
        "getCustomerOrderingInfo": "getCustomerOrderingInfo"
    ]
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
