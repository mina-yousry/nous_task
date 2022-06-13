// 
//  UIViewController+Extension.swift
//  Koinz
// 
//  Created by Koinz on 19/12/2021.
//  Copyright © 2021 GPlanet. All rights reserved.
// 

import Foundation
import NVActivityIndicatorView

extension UIViewController {
    
    func startProgressAnimation() {
        let activityData = ActivityData(size: CGSize(width: 80.0, height: 80.0),
                                        message: nil,
                                        messageFont: nil,
                                        messageSpacing: nil,
                                        type: NVActivityIndicatorType.orbit,
                                        color: UIColor.blue,
                                        padding: nil,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil,
                                        backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5),
                                        textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
        
    }
    
    func stopProgressAnimation() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }
}
