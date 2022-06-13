// 
//  UIViewController+Extension.swift
//  Koinz
// 
//  Created by Koinz on 19/12/2021.
//  Copyright © 2021 GPlanet. All rights reserved.
// 

import Foundation
import PopupDialog
import NVActivityIndicatorView
import IQKeyboardManager

extension UIViewController {
    
    func showAlert(title: String,
                   message: String = "",
                   okAction: SimpleFunction?,
                   skipAction: SimpleFunction?,
                   skipButtonTitle: String = "cancel".l10n(),
                   okButtonTitle: String = "alert_ok".l10n()) {
        let alertVC = ShopxAlerViewController(nibName: "ShopxAlerViewController", bundle: nil)
        alertVC.okayButtonTitle = okButtonTitle
        alertVC.cancelButtonTitle = skipButtonTitle
        alertVC.titleMessage = title
        alertVC.contentMessage = message
        alertVC.okAction = okAction
        alertVC.skipAction = skipAction
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        if let topVc = UIApplication.topViewController() {
            if !(topVc.isKind(of: UIAlertController.self)) {
                topVc.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    func displayAlert(title: String, message: String, action: SimpleFunction? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: "dismiss".l10n(),
                                          style: UIAlertAction.Style.default,
                                          handler: { _ in
            if let action = action {
                action()
            }
        })
        alert.addAction(dismissAction)
        if let topVc = UIApplication.topViewController(), !(topVc is PopupDialog) {
            if !(topVc.isKind(of: UIAlertController.self)) {
                topVc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func startProgressAnim() {
        
        let activityData = ActivityData(size: CGSize(width: 80.0, height: 80.0),
                                        message: nil,
                                        messageFont: nil,
                                        messageSpacing: nil,
                                        type: NVActivityIndicatorType.orbit,
                                        color: ShopXStyle.yellowColor,
                                        padding: nil,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil,
                                        backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5),
                                        textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
        
    }
    
    func stopProgressAnim() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureKeyboardToolBar(isEnabled: Bool) {
        IQKeyboardManager.shared().isEnableAutoToolbar = isEnabled
    }
    
    func ShowNoNetworkPopup(refreshable: Refreshable? = nil, reloadAction: SimpleFunction? = nil) {
        let networkPopupVc = NoInternetPopupViewController(nibName: "NoInternetPopupViewController", bundle: nil)
        networkPopupVc.owner = refreshable
        networkPopupVc.reloadAction = reloadAction
        let networkPopup = PopupDialog(viewController: networkPopupVc)
        self.present(networkPopup, animated: true, completion: nil)
    }
    
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
