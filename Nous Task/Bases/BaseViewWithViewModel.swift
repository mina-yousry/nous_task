//
//  BaseViewWithViewModel.swift
//  Koinz
//
//  Created by Mina Maged on 06/04/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Action

class BaseViewWithViewModel: UIView {
    
    // MARK: - Global Variables
    var viewModel: ViewModelType?
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeViews()
    }
    
    func initializeViews() {}
    
    func bindViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
        self.bindLoadingLogic()
    }
    
    private func bindLoadingLogic() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false)
        .drive(onNext: { [weak self] isLoading in
            if isLoading {
                self?.startLoading()
            } else {
                self?.endLoading()
            }
        }, onCompleted: { [weak self] in
            self?.endLoading()
        }, onDisposed: { [weak self] in
            self?.endLoading()
        }).disposed(by: disposeBag)
        
        viewModel?.error.subscribe(onNext: { [weak self] error in
            self?.handleError(error)
        }).disposed(by: disposeBag)
    }
    
    func handleError(_ error: RepoError) {
        switch error {
        case .invalidToken:
            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.logout()
        default:
            break
        }
    }
    
    func startLoading() { }
    
    func endLoading() { }
    
    // Responsability of the coordinator
    static func getView<T: BaseViewWithViewModel>(viewModel: ViewModelType) -> T {
        let view: T = .instanceFromNib()
        view.bindViewModel(viewModel: viewModel)
        return view
    }
}
