//
//  BindableType.swift
//
//  Created by Mina Yousry on 25/01/2022.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol BindableType: AnyObject {
    
    associatedtype ViewModel
    
    var viewModel: ViewModel? { get set }
    func initializeViews()
    func bindViewModel()
    func postDismissAction()
    func startLoading()
    func endLoading()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to model: ViewModel) {
        viewModel = model
        loadViewIfNeeded()
        initializeViews()
        bindViewModel()
    }
}
