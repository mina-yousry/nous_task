//
//  DataSource.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation

class DataSource: BaseRemoteDataSource {
    
    var repo: Repo?
    
    override init(repo: BaseRepo?) {
        super.init(repo: repo)
        self.repo = repo as? Repo
    }
 
    func getData() {
        let req = GetDataRequest()
        let response = self.repo?.response
        self.remoteFetcher.getRemoteResponse(request: req, responseObservable: response)
    }
}
