//
//  ItemsCoordinator.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import MessageUI

class ItemsCoordinator: BaseCoordinator<ItemsControllerRoutes> {
    
    var itemsController: ItemsViewController?
    var window: UIWindow?
    
    init(window: UIWindow?, rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController)
        self.window = window
    }
    
    func start() {
        itemsController = ItemsViewController.init(nibName: "ItemsViewController", bundle: nil)
        let itemsViewModel = ItemsViewModel(coordinator: self)
        itemsController?.bindViewModel(to: itemsViewModel)
        rootViewController.setViewControllers([self.itemsController!], animated: false)
        self.window?.rootViewController = rootViewController
    }
    
    override func performRouting(for router: ItemsControllerRoutes) {
        switch router {
        case .sendEmail(let title, let body):
            if MFMailComposeViewController.canSendMail(){
                let mailComposerVC = MFMailComposeViewController()
                mailComposerVC.setSubject(title)
                mailComposerVC.setMessageBody(body, isHTML: false)
                itemsController?.present(mailComposerVC, animated: true, completion: nil)
            }
        }
    }
    
}

enum ItemsControllerRoutes: BaseRouterProtocol {
    case sendEmail(title: String, body: String)
}
