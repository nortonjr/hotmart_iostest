//
//  SalesCoordinator.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 11/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit

class SalesCoordinator: Coordinator {

    var window: UIWindow
    var appCoordinator: AppCoordinator?

    fileprivate lazy var baseViewController: UINavigationController? = {
        R.storyboard.sales.instantiateInitialViewController()
    }()

    required init(window: UIWindow) {
        self.window = window
        self.appCoordinator = nil
    }

    convenience init(window: UIWindow, appCoordinator: AppCoordinator) {
        self.init(window: window)
        self.appCoordinator = appCoordinator
    }

    func start() {
        guard let navigationController = baseViewController else { return }

        let salesViewController = R.storyboard.sales.salesViewController()!
        navigationController.viewControllers = [salesViewController]
        present(navigationController.view)
    }

    func present(_ view: UIView) {
        appCoordinator?.presentTabView(view)
    }
}
