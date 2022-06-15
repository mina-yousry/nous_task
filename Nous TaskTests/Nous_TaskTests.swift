//
//  Nous_TaskTests.swift
//  Nous TaskTests
//
//  Created by Mina Yousry on 6/13/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import XCTest
import RxSwift

@testable import Nous_Task

class Nous_TaskTests: XCTestCase {

    var viewModel: ItemsViewModel?
    var disposeBag: DisposeBag?
    
    override func setUp() {
        viewModel = ItemsViewModel(coordinator: nil)
        disposeBag = DisposeBag()
    }
    
    func test_fetchDataFromApi() {
        viewModel?.items.subscribe(onNext: { items in
            XCTAssertEqual(items.count, 8)
            XCTAssertEqual(items.first?.title, "Die ewige Welle")
        }).disposed(by: disposeBag!)
        viewModel?.repo.getData()
    }
    
    func test_search_title() {
        viewModel?.items.skip(1).subscribe(onNext: { items in
            XCTAssertEqual(items.count, 1)
            XCTAssertEqual(items.first?.title, "Die ewige Welle")
        }).disposed(by: disposeBag!)
        viewModel?.searchText.accept("die ewige")
    }
    
    func test_search_description() {
        viewModel?.items.skip(1).subscribe(onNext: { items in
            XCTAssertEqual(items.count, 1)
            XCTAssertEqual(items.first?.title, "Die ewige Welle")
        }).disposed(by: disposeBag!)
        viewModel?.searchText.accept("mikesch war anfang der 80er-Jahre ein enger freund von Leitmayr")
    }
    
    func test_search_notFound() {
        viewModel?.items.skip(1).subscribe(onNext: { items in
            XCTAssertEqual(items.count, 0)
        }).disposed(by: disposeBag!)
        viewModel?.searchText.accept("fgdfgsdgsdgdfgsdfdfg")
    }
    
    func test_search_empty() {
        viewModel?.items.skip(1).subscribe(onNext: { items in
            XCTAssertEqual(items.count, 8)
        }).disposed(by: disposeBag!)
        viewModel?.searchText.accept("")
    }
    
    override func tearDown() {
        viewModel = nil
        disposeBag = nil
    }

}
