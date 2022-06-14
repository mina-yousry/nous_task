//
//  Providers.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation

class  Providers {
    static let apiProvider = MoyaPrviderFactory<Api>().create()
}
