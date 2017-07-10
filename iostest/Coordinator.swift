//
//  Coordinator.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 08/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var window: UIWindow { get }

    init(window: UIWindow)

    func start()
}

extension Coordinator {

    var tabBarController: UITabBarController? {
        return self.window.rootViewController as? UITabBarController
    }

    var currentViewController: UIViewController? {
        let selectedViewController = tabBarController?.selectedViewController

        return (selectedViewController as? UINavigationController)?.topViewController ?? selectedViewController
    }
}
