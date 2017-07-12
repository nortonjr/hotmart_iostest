//
//  MainContainerViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

class MainContainerViewModel: ViewModel {

    let coordinator: AppCoordinator
    let disposeBag: DisposeBag = DisposeBag()

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: Actions

extension MainContainerViewModel {

    func selectedTabBar(tab: Int) {
        switch tab {
        case 0:
            showMessages()
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }

    fileprivate func showMessages() {
        coordinator.presentTab(index: 1)
    }
}
