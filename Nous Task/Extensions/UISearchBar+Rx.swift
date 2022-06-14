//
//  UISearchBar+Rx.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/15/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

extension UISearchBar: HasDelegate {
    public typealias Delegate = UITextFieldDelegate
}

class RxUISearchBarDelegateProxy: DelegateProxy<UISearchBar, UISearchBarDelegate>, DelegateProxyType, UISearchBarDelegate {
    
    public weak private(set) var searchBar: UISearchBar?
    
    init(searchBar: UISearchBar) {
        self.searchBar = searchBar
        super.init(parentObject: searchBar, delegateProxy: RxUISearchBarDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxUISearchBarDelegateProxy(searchBar: $0)}
    }
}

extension Reactive where Base: UISearchBar {
    
    public var delegate: DelegateProxy<UISearchBar, UISearchBarDelegate> {
        return RxUISearchBarDelegateProxy.proxy(for: base)
    }
    
    public var textChanged: Observable<String> {
        let textDidChange: Selector = #selector(UISearchBarDelegate.searchBar(_:textDidChange:))
        return delegate.sentMessage(textDidChange)
            .map(mapSearchBarToText)
    }
    
    public func mapSearchBarToText(_ sender: [Any]) -> String {
        guard let searchBar = sender.first as? UISearchBar else { return "" }
        return searchBar.text ?? ""
    }
}
