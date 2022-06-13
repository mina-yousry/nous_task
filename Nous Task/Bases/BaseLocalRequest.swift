//
//  KoinzOfflineRequest.swift
//  Koinz
//
//  Created by Mina Maged on 03/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import RealmSwift

class BaseLocalRequest<M: DomainObject> {

    var query: NSPredicate?
    var sortedBy: [SortingCrieteria]?
    
    init(query: NSPredicate?, sortedBy: [SortingCrieteria]?) {
        self.query = query
        self.sortedBy = sortedBy
    }
}

struct SortingCrieteria {
    var keyPath: String
    var ascending: Bool
}
