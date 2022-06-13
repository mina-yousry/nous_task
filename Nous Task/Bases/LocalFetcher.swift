//
//  LocalFetcher.swift
//  Koinz
//
//  Created by Mina Maged on 09/02/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import RealmSwift

class LocalFetcher {
    func getLocalResponse<M: DomainObject, Q: BaseLocalRequest<M>>(request: Q) -> [M] {
        let realm = try? Realm()
        var objects = realm?.objects(M.self)
        if let filterBy = request.query {
            objects = objects?.filter(filterBy)
        }
        if let sortedBy = request.sortedBy {
            var sortingCrieterias: [RealmSwift.SortDescriptor] = []
            sortedBy.forEach({ crieteria in
                sortingCrieterias.append(SortDescriptor(keyPath: crieteria.keyPath,
                                                        ascending: crieteria.ascending))
            })
            objects = objects?.sorted(by: sortingCrieterias)
        }
        let objectsArray = objects?.toArray()
        return objectsArray ?? []
    }
}

class DomainObject: Object {
    @Persisted var dummyId: String? = ""
    
    override init() {
        super.init()
        self.dummyId = ""
    }
    
    init(dummyId: String? = "") {
        super.init()
        self.dummyId = dummyId
    }
}
