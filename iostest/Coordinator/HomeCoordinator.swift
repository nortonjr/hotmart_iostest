//
//  HomeCoordinator.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {

    var window: UIWindow
    var appCoordinator: AppCoordinator?

    fileprivate lazy var baseViewController: UINavigationController? = {
        R.storyboard.home.instantiateInitialViewController()
    }()

    required init(window: UIWindow) {
        self.window = window
        appCoordinator = nil
    }

    convenience init(window: UIWindow, appCoordinator: AppCoordinator) {
        self.init(window: window)
        self.appCoordinator = appCoordinator
    }

//    fileprivate weak var homeViewController: HomeViewController?
    fileprivate weak var navigationController: UINavigationController?

    func start() {
        guard let navigationController = baseViewController else { return }
        self.navigationController = navigationController

        let homeViewController = R.storyboard.home.homeViewController()!
        homeViewController.viewModel = HomeViewModel(coordinator: self)
        navigationController.viewControllers = [homeViewController]
        present((navigationController.viewControllers.first?.view)!)
    }

    func restart() {

        let homeViewController = R.storyboard.home.homeViewController()!
        homeViewController.viewModel = HomeViewModel(coordinator: self)
        presentDashboard(homeViewController.view)
    }
}

// MARK: Actions

extension HomeCoordinator {

    func present(_ view: UIView) {
        appCoordinator?.present(view)
    }

    func presentDashboard(_ view: UIView) {
        appCoordinator?.injectDashboard(view)
    }
}
