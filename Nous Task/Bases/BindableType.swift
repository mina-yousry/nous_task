//
//  BindableType.swift
//  Koinz
//
//  Created by Mina Yousry on 25/01/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol BindableType: AnyObject {
    
    var viewModel: ViewModelType? { get set }
    func initializeViews()
    func bindViewModel()
    func postDismissAction()
    func startLoading()
    func endLoading()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to model: ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        initializeViews()
        bindViewModel()
    }
}
