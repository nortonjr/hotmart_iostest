//
//  HomeViewModel.swift
//  iostest
//
//  Created by Norton Pigozzo Martins Junior on 09/07/17.
//  Copyright © 2017 Norton Pigozzo. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel: ViewModel {

    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: HomeCoordinator!

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: Actions

extension HomeViewModel {

    func present(_ view: UIView) {
        coordinator.present(view)
    }
}
