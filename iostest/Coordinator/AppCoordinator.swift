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

    fileprivate weak var navigationController: UINavigationController?

    required init(window: UIWindow) {
        self.window = window
    }

    func start() {
        guard let navigationController = baseViewController  else { fatalError("Error initializing main view controller") }

        let mainViewController = R.storyboard.main.mainContainerViewController()!
        mainViewController.viewModel = MainContainerViewModel(coordinator: self)
        navigationController.viewControllers = [mainViewController]

        let homeCoordinator: HomeCoordinator = HomeCoordinator(window: window, appCoordinator: self)

        self.childCoordinators[.home] = homeCoordinator
        homeCoordinator.start()

        let messagesCoordinator: MessagesCoordinator = MessagesCoordinator(window: window, appCoordinator: self)
        self.childCoordinators[.messages] = messagesCoordinator

        let salesCoordinator: SalesCoordinator = SalesCoordinator(window: window, appCoordinator: self)
        self.childCoordinators[.sales] = salesCoordinator

        window.rootViewController = navigationController

        navigationController.navigationBar.barTintColor = Stylesheet.Color.mainOrange
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.topItem?.title = "Dashboard"
        self.navigationController = navigationController
        installAppearence()
    }

    func installAppearence() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}

// MARK: Lifecycle

extension AppCoordinator {

    func present(_ view: UIView) {
        guard let mainViewController = baseViewController?.viewControllers.first as? MainContainerViewController else { return }

        mainViewController.presentingView = view
    }

    func presentTabView(_ view: UIView) {
        guard let mainViewController = baseViewController?.viewControllers.first as? MainContainerViewController else { return }
        mainViewController.contentView.subviews.first?.removeFromSuperview()
        view.frame.size.height = mainViewController.contentView.frame.size.height
        mainViewController.contentView.addSubview(view)
    }

    func presentTab(index: Int) {
        switch index {
        case 0:
            self.childCoordinators[.messages]?.start()
        case 1:
            self.childCoordinators[.sales]?.start()
        default:
            break
        }

        setupNavBarAppearence(index: index)
    }

    func setupNavBarAppearence(index: Int) {
        switch index {
        case 0:
            navigationController?.navigationBar.topItem?.title = "Mensagens"
            navigationController?.navigationBar.barTintColor = Stylesheet.Color.mainYellow
        case 1:
            navigationController?.navigationBar.topItem?.title = "Minhas Vendas"
            navigationController?.navigationBar.barTintColor = Stylesheet.Color.mainBlue
        default:
            break
        }
    }
}
