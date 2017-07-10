//
//  AppCoordinator.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 08/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit
import SwiftyColor

class AppCoordinator: Coordinator {

    enum CoordinatorKey: String {
        case home, messages, sales, menu
    }

    var window: UIWindow
    var childCoordinators: [CoordinatorKey: Coordinator] = [:]
    var initialCoordinator: CoordinatorKey = .home

    fileprivate lazy var baseViewController: UINavigationController? = {
        return R.storyboard.main.instantiateInitialViewController()
    }()

    required init(window: UIWindow) {
        self.window = window
    }

    func start() {
        guard let navigationController = baseViewController  else { fatalError("Error initializing main view controller") }

        let mainViewController = R.storyboard.main.mainContainerViewController()!
        navigationController.viewControllers = [mainViewController]

        let homeCoordinator: HomeCoordinator = HomeCoordinator(window: window, appCoordinator: self)

        self.childCoordinators[.home] = homeCoordinator
        homeCoordinator.start()

        window.rootViewController = navigationController
        navigationController.navigationController?.title = "Dashboard"
        navigationController.navigationBar.barTintColor = 0xD04F2A.color
    }
}

// MARK: Lifecycle

extension AppCoordinator {

    func present(_ view: UIView) {
        guard let mainViewController = baseViewController?.viewControllers.first as? MainContainerViewController else { return }

        mainViewController.presentingView = view
    }
}
