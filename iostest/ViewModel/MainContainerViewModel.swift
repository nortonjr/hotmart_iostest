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
        coordinator.presentTab(index: tab)
    }
}
