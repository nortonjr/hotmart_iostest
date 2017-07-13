//
//  MenuViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 12/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

class MenuViewModel: ViewModel, RxDisposableCompatible {

    typealias SectionType = SectionViewModelType<MenuItem>

    let disposeBag: DisposeBag = DisposeBag()
    let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    var items: Driver<[SectionType]> {
        var menuItems: [MenuItem] = []

        menuItems = [MenuItemViewModel(type: .dashboard), MenuItemViewModel(type: .sales), MenuItemViewModel(type: .products),MenuItemViewModel(type: .afiliates), MenuItemViewModel(type: .messages, style: .lightGrey), MenuItemViewModel(type: .notifications, style: .lightGrey), MenuItemViewModel(type: .account),
                 MenuItemViewModel(type: .about)]

        return Driver.just([SectionViewModelType(viewModels: menuItems)])
    }

    func executeAction(type: MenuActionType) {
        switch type {
        case .dashboard:
            appCoordinator.presentDashboard()
        case .messages:
            appCoordinator.presentTab(index: 0)
        case .sales:
            appCoordinator.presentTab(index: 1)
        default:
            break
        }

        appCoordinator.dismissMenu()
    }
}
