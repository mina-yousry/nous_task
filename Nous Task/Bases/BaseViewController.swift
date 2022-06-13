//
//  BaseViewController.swift
//  Koinz
//
//  Created by Mina Yousry on 25/01/2022.
//  Copyright © 2022 GPlanet. All rights reserved.
//

import UIKit
import SkeletonView
import RxSwift
import Action
import RxCocoa

class BaseViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dissmissView: UIView!
    
    // MARK: - Global Variables
    var refreshAction: SimpleFunction? {
        return nil
    }
    var viewModel: ViewModelType?
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Class Methods
    func initializeViews() {
        guard let closeButton = self.dissmissView else { return }
        let closeGuesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        closeButton.addGestureRecognizer(closeGuesture)
    }
    
    func bindViewModel() {
        self.bindLoadingLogic()
    }
    
    func postDismissAction() {}
    
    func startLoading() {
        self.startProgressAnim()
    }
    
    func endLoading() {
        self.stopProgressAnim()
    }
    
    // MARK: - Private Methods
    @objc private func dismissViewController() {
        self.postDismissAction()
        self.viewModel?.close()
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
        case .generic:
            self.displayAlert(title: "error".l10n(), message: "server_error_desc".l10n())
        case .noConnection:
            self.ShowNoNetworkPopup(refreshable: self, reloadAction: refreshAction)
        case .invalidToken:
            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.logout()
        case .server:
            self.displayAlert(title: "error".l10n(), message: "server_error_desc".l10n())
        case .parsing:
            break
        case .backEnd(let code, let body, let name):
            self.handleBackendError(code: code, body: body, name: name)
        case .emptyResponse:
            break
        }
    }
    
    func handleBackendError(code: Int, body: [String: Any], name: String) {
        if let localizedMessage = body["localized_message"] as? String {
            self.displayAlert(title: "error".l10n(), message: localizedMessage)
        } else if let message = body["err_message"] as? String {
            self.displayAlert(title: "error".l10n(), message: message)
        } else {
            self.displayAlert(title: "error".l10n(), message: "network_error_desc".l10n())
        }
    }
}

extension BaseViewController: Refreshable {
    var id: String {
        return "\(type(of: self))"
    }
}
